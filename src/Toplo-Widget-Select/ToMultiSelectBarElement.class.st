Class {
	#name : #ToMultiSelectBarElement,
	#superclass : #ToTagBarElement,
	#traits : 'TToDropdownInnerContainerElement + TToSelectInnerContainerElement',
	#classTraits : 'TToDropdownInnerContainerElement classTrait + TToSelectInnerContainerElement classTrait',
	#instVars : [
		'maxSelectedCount',
		'keepPickOrder',
		'pickCount',
		'filterTextField',
		'dropdownButton'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> allowSelectedCount: aNumber [

	^ maxSelectedCount isZero or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> checkHideSelectionFromListElement [

	dropdownButton hideSelected ifFalse: [ ^ self ].
	self popupListElement hideSelection
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> checkMaxSelectedCount [

	| sM disabledSM groupeSM selectedCount |
	maxSelectedCount isZero ifTrue: [ ^ self ].

	disabledSM := self popupListElement disabledSelectionModel.
	groupeSM := self popupListElement groupSelectionModel.
	sM := self popupListElement selectionModel.

	dropdownButton updateSelectedCountLabel.
	selectedCount := dropdownButton selectionModel selectedIndexesCount.

	"self assertMaxSelectedCount: selectedIndexCount."
	self sieve withLocalAndOriginalIndexDo: [ :d :localIndex :originalIndex |
		(groupeSM containsIndex: localIndex) ifFalse: [
			selectedCount < maxSelectedCount
				ifTrue: [ disabledSM deselectIndex: localIndex ]
				ifFalse: [
					(dropdownButton selectionModel containsIndex: originalIndex)
						ifFalse: [ disabledSM selectIndex: localIndex ] ].
			" to transfer the selection to the sieve selection model "
			sM
				transferSelectionFromIndex: localIndex
				toIndex: originalIndex
				in: dropdownButton selectionModel ] ].

	self popupListElement notifyDataSourceChanged
]

{ #category : #'t - dropdown inner container' }
ToMultiSelectBarElement >> dropdownButton [ 

	^ dropdownButton 
]

{ #category : #'t - dropdown inner container' }
ToMultiSelectBarElement >> dropdownButton: aDropdownButton [

	dropdownButton := aDropdownButton
]

{ #category : #layout }
ToMultiSelectBarElement >> extentChanged [

	super extentChanged.
	self refreshFromPopupListSelection
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> filterTextField [ 

	^ filterTextField 
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> filterTextField: aTextField [

	filterTextField := aTextField 
]

{ #category : #layout }
ToMultiSelectBarElement >> haveInvisibleNodes: theInvisibleNodes [

	| visibleNodes invisibleNodes composite finalCount |
	theInvisibleNodes ifEmpty: [ ^ self ].
	" in case of composite node at first it means that 
	there is no more visible node to cumulate in a composite node"
	self nodes size = 1 ifTrue: [ ^ self ].

	visibleNodes := self nodesSelect: [ :n | n isFullyVisible ].
	invisibleNodes := theInvisibleNodes copy.
	visibleNodes ifNotEmpty: [
		invisibleNodes := theInvisibleNodes copyWith: visibleNodes last.
		visibleNodes := visibleNodes copyWithout: visibleNodes last ].
	" now cumulate invisible nodes in a composite tag model "
	composite := ToCompositeTagModel new.
	composite items: (Array streamContents: [ :stream |
			 invisibleNodes do: [ :n |
				 stream nextPutAll: n holder dataItem items ] ]).
	finalCount := self nodesCount - visibleNodes size.
	composite content: '+ ' , finalCount asString , ' ...'.
	invisibleNodes do: [ :node |
		self dataAccessor removeAt: node holder position ].
	self dataAccessor add: composite
]

{ #category : #initialization }
ToMultiSelectBarElement >> initialize [

	super initialize.

	" no visible primary and secondary selection elements "
	self selectionOption masked: true.
	self primarySelectionMode makeDisabledUnselectable: true.
	self secondarySelectionMode selectionOption masked: true.
	self nodeHolderClass: ToMultiSelectHolder.
	maxSelectedCount := 0.
	keepPickOrder := false.
	pickCount := 0.

	self installFilterTextField
]

{ #category : #accessing }
ToMultiSelectBarElement >> keepPickOrder [

	^ keepPickOrder 
]

{ #category : #accessing }
ToMultiSelectBarElement >> keepPickOrder: aBoolean [

	keepPickOrder := aBoolean.
	self refreshFromPopupListSelection
]

{ #category : #accessing }
ToMultiSelectBarElement >> listElement [

	self
		deprecated: 'Use #popupListElement'
		transformWith: '`@rcvr listElement' -> '`@rcvr popupListElement'.

	^ self popupListElement
]

{ #category : #accessing }
ToMultiSelectBarElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber.
	self refreshFromPopupListSelection
]

{ #category : #accessing }
ToMultiSelectBarElement >> popupListElement [


	^ dropdownButton popupListElement
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> refresh [

	self
		deprecated: '#refreshFromPopupListSelection instead'
		transformWith:
		'`@rcvr refresh' -> '`@rcvr refreshFromPopupListSelection'.
	self refreshFromPopupListSelection
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> refreshFromPopupListSelection [
	" rebuild the current bar nodes according to the selection in the popup list "

	| previousTagModels newTagModels |
	dropdownButton showHidePlaceholder.
	" copy the previous tag models "
	previousTagModels := self dataAccessor asOrderedCollection.
	newTagModels := OrderedCollection new.
	" take care of a possible composite tag models that represents a list of items "
	previousTagModels ifNotEmpty: [
		| last |
		last := previousTagModels last.
		last isComposite ifTrue: [
			previousTagModels removeLast.
			previousTagModels addAll: last items ] ].

	" reconstruct the item list. ensure the reuse of pre-existing items"
	dropdownButton selectionModel selectedIndexesDo: [ :idx |
		| new previous data |
		data := dropdownButton sieve originalData at: idx.
		previous := previousTagModels
			            detect: [ :item | item data = data ]
			            ifNone: [  ].
		previous
			ifNotNil: [
				new := previous.
				previousTagModels remove: previous ]
			ifNil: [
				new := ToPickedTagModel new
					       data: data;
					       yourself.
				pickCount := pickCount + 1.
				new pickOrder: pickCount ].
		newTagModels add: new ].

	keepPickOrder ifTrue: [
		newTagModels sort: [ :a :b | a pickOrder < b pickOrder ] ].

	" replace all in one datasource command "
	self dataAccessor updateAllWith: newTagModels.
	self checkHideSelectionFromListElement.
	self checkMaxSelectedCount
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> selectElement [

	^ dropdownButton
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> selectElement: aSelectElement [

	dropdownButton := aSelectElement
]

{ #category : #accessing }
ToMultiSelectBarElement >> sieve [

	^ dropdownButton sieve
]
