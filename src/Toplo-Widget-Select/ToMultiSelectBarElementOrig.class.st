Class {
	#name : #ToMultiSelectBarElementOrig,
	#superclass : #ToTagBarElement,
	#traits : 'TToSelectInnerContainerElement + TToElementWithPlaceholder',
	#classTraits : 'TToSelectInnerContainerElement classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectElement',
		'maxSelectedCount',
		'keepPickOrder',
		'pickCount',
		'filterTextField'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'accessing - selection' }
ToMultiSelectBarElementOrig >> allowSelectedCount: aNumber [

	^ maxSelectedCount isZero or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElementOrig >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElementOrig >> checkHideSelectionFromListElement [

	selectElement hideSelected ifFalse: [ ^ self ].
	self popupListElement hideSelection
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElementOrig >> checkMaxSelectedCount [

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

{ #category : #'t - bar element' }
ToMultiSelectBarElementOrig >> defaultInnerElementClass [

	^ ToMultiSelectInnerBarElement
]

{ #category : #initialization }
ToMultiSelectBarElementOrig >> defaultLayout [

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToMultiSelectBarElementOrig >> defaultNodeManagerClass [ 

	^ ToMultiSelectNodeManager
]

{ #category : #layout }
ToMultiSelectBarElementOrig >> extentChanged [

	super extentChanged.
	self refreshHeaderFromPopupListSelection
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElementOrig >> filterTextField [ 

	^ filterTextField 
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElementOrig >> filterTextField: aTextField [

	filterTextField := aTextField 
]

{ #category : #initialization }
ToMultiSelectBarElementOrig >> initialize [

	super initialize.

	" no visible primary and secondary selection elements "
	self selectionOption masked: true.
	self primarySelectionMode makeDisabledUnselectable: true.
	self secondarySelectionMode selectionOption masked: true.
	self focusability: BlFocusability ignore.
	maxSelectedCount := 0.
	keepPickOrder := false.
	pickCount := 0.

	self installFilterTextField
]

{ #category : #accessing }
ToMultiSelectBarElementOrig >> keepPickOrder [

	^ keepPickOrder 
]

{ #category : #accessing }
ToMultiSelectBarElementOrig >> keepPickOrder: aBoolean [

	keepPickOrder := aBoolean.
	self refreshHeaderFromPopupListSelection
]

{ #category : #accessing }
ToMultiSelectBarElementOrig >> listElement [

	self
		deprecated: 'Use #popupListElement'
		transformWith: '`@rcvr listElement' -> '`@rcvr popupListElement'.

	^ self popupListElement
]

{ #category : #accessing }
ToMultiSelectBarElementOrig >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber.
	self refreshHeaderFromPopupListSelection
]

{ #category : #accessing }
ToMultiSelectBarElementOrig >> popupListElement [


	^ selectElement popupListElement
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElementOrig >> refresh [

	self
		deprecated: '#refreshFromPopupListSelection instead'
		transformWith:
		'`@rcvr refresh' -> '`@rcvr refreshFromPopupListSelection'.
	self refreshHeaderFromPopupListSelection
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElementOrig >> refreshHeaderFromPopupListSelection [
	" rebuild the current bar nodes according to the selection in the popup list "

	| previousTagModels newTagModels |
	selectElement showHidePlaceholder.
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
				new := ToPickedTag new
					       data: data;
					       yourself.
				pickCount := pickCount + 1.
				new pickOrder: pickCount ].
		newTagModels add: new ].

	keepPickOrder ifTrue: [
		newTagModels sort: [ :a :b | a pickOrder < b pickOrder ] ].

	" if the list has changed then replace all in one datasource command "
	self dataAccessor asOrderedCollection = newTagModels ifTrue: [ ^ self ].
	self dataAccessor removeAll.
	self dataAccessor addAll: newTagModels.
	self checkHideSelectionFromListElement.
	self checkMaxSelectedCount
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElementOrig >> selectElement [

	^ selectElement
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElementOrig >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToMultiSelectBarElementOrig >> sieve [

	^ selectElement sieve
]
