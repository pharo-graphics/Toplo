Class {
	#name : #ToMultiSelectBarElement,
	#superclass : #ToTagBarElement,
	#traits : 'TToSelectInnerContainerElement',
	#classTraits : 'TToSelectInnerContainerElement classTrait',
	#instVars : [
		'selectElement',
		'maxSelectedCount',
		'keepPickOrder',
		'pickCount',
		'filterTextField'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToMultiSelectBarElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

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

	selectElement hideSelected ifFalse: [ ^ self ].
	self popupListElement hideSelection
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> checkMaxSelectedCount [

	| sM disabledSM groupeSM selectedCount |
	maxSelectedCount isZero ifTrue: [ ^ self ].

	disabledSM := self popupListElement disabledSelectionModel.
	groupeSM := self popupListElement groupSelectionModel.
	sM := self popupListElement selectionModel.

	selectElement updateSelectedCountLabel.
	selectedCount := selectElement selectionModel selectedIndexesCount.

	"self assertMaxSelectedCount: selectedIndexCount."
	self sieve withLocalAndOriginalIndexDo: [ :d :localIndex :originalIndex |
		(groupeSM containsIndex: localIndex) ifFalse: [
			selectedCount < maxSelectedCount
				ifTrue: [ disabledSM deselectIndex: localIndex ]
				ifFalse: [
					(selectElement selectionModel containsIndex: originalIndex)
						ifFalse: [ disabledSM selectIndex: localIndex ] ].
			" to transfer the selection to the sieve selection model "
			sM
				transferSelectionFromIndex: localIndex
				toIndex: originalIndex
				in: selectElement selectionModel ] ].

	self popupListElement notifyDataSourceChanged
]

{ #category : #initialization }
ToMultiSelectBarElement >> defaultNodeManager [

	^ ToMultiSelectNodeManager new
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

{ #category : #skin }
ToMultiSelectBarElement >> newRawSkin [ 

	^ ToMultiSelectBarElementSkin new
]

{ #category : #accessing }
ToMultiSelectBarElement >> popupListElement [


	^ selectElement popupListElement
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
	selectElement selectionModel selectedIndexesDo: [ :idx |
		| new previous data |
		data := selectElement sieve originalData at: idx.
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

	^ selectElement
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToMultiSelectBarElement >> sieve [

	^ selectElement sieve
]
