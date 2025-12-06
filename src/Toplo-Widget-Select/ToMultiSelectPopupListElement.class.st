Class {
	#name : #ToMultiSelectPopupListElement,
	#superclass : #ToGenericFiniteListElement,
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

{ #category : #'instance creation' }
ToMultiSelectPopupListElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #'accessing - selection' }
ToMultiSelectPopupListElement >> allowSelectedCount: aNumber [

	^ self haveMaxSelectedCount not or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToMultiSelectPopupListElement >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToMultiSelectPopupListElement >> checkHideSelectionFromListElement [

	selectElement hideSelected ifFalse: [ ^ self ].
	self popupListElement inUIProcessDo: [ self popupListElement hideSelection ]
]

{ #category : #'accessing - selection' }
ToMultiSelectPopupListElement >> checkMaxSelectedCount [

	| sM disabledSM groupeSM selectedCount prevDisabledSM |
	self haveMaxSelectedCount ifFalse: [ ^ self ].

	disabledSM := self popupListElement disabledSelectionModel.
	groupeSM := self popupListElement groupSelectionModel.
	sM := self popupListElement selectionModel.

	selectedCount := selectElement selectionModel selectedIndexesCount.
	prevDisabledSM := disabledSM copy.

	self sieve withLocalAndOriginalIndexDo: [ :d :localIndex :originalIndex |
			(groupeSM containsIndex: localIndex) ifFalse: [
					selectedCount < maxSelectedCount
						ifTrue: [ disabledSM deselectIndex: localIndex ]
						ifFalse: [
								(selectElement selectionModel containsIndex: originalIndex)
									ifFalse: [ disabledSM selectIndex: localIndex ] ] ] ].

	self sieve pattern isEmpty and: [
		prevDisabledSM = disabledSM ifTrue: [ ^ self ] ].
	self popupListElement notifyDataSourceChanged
]

{ #category : #'accessing - selection' }
ToMultiSelectPopupListElement >> checkMaxSelectedCountOld [

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
ToMultiSelectPopupListElement >> defaultInnerElementClass [

	^ ToMultiSelectPopupInnerListElement
]

{ #category : #initialization }
ToMultiSelectPopupListElement >> defaultLayout [

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToMultiSelectPopupListElement >> defaultNodeManagerClass [ 

	^ ToMultiSelectPopupNodeManager
]

{ #category : #layout }
ToMultiSelectPopupListElement >> extentChanged [

	super extentChanged.
	self updateFromPopupListSelection
]

{ #category : #'t - select inner container' }
ToMultiSelectPopupListElement >> filterTextField [ 

	^ filterTextField 
]

{ #category : #'t - select inner container' }
ToMultiSelectPopupListElement >> filterTextField: aTextField [

	filterTextField := aTextField 
]

{ #category : #'accessing - selection' }
ToMultiSelectPopupListElement >> haveMaxSelectedCount [

	^ maxSelectedCount ~= -1
]

{ #category : #initialization }
ToMultiSelectPopupListElement >> initialize [

	super initialize.

	" no visible primary and secondary selection elements "
	self selectionOption masked: true.
	self selectionMode makeDisabledUnselectable: true.
	self secondarySelectionOption masked: true.
	self focusability: BlFocusability ignore.
	maxSelectedCount := -1.
	keepPickOrder := false.
	pickCount := 0.

	self installFilterTextField
]

{ #category : #accessing }
ToMultiSelectPopupListElement >> keepPickOrder [

	^ keepPickOrder 
]

{ #category : #accessing }
ToMultiSelectPopupListElement >> keepPickOrder: aBoolean [

	keepPickOrder := aBoolean.
	self updateFromPopupListSelection
]

{ #category : #accessing }
ToMultiSelectPopupListElement >> listElement [

	self
		deprecated: 'Use #popupListElement'
		transformWith: '`@rcvr listElement' -> '`@rcvr popupListElement'.

	^ self popupListElement
]

{ #category : #accessing }
ToMultiSelectPopupListElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
]

{ #category : #accessing }
ToMultiSelectPopupListElement >> popupListElement [


	^ selectElement popupListElement
]

{ #category : #'t - select inner container' }
ToMultiSelectPopupListElement >> refreshFromPopupListSelection [
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

{ #category : #'accessing - selection' }
ToMultiSelectPopupListElement >> removeMaxSelectedCount [

	maxSelectedCount := -1
]

{ #category : #'t - select inner container' }
ToMultiSelectPopupListElement >> selectElement [

	^ selectElement
]

{ #category : #'t - select inner container' }
ToMultiSelectPopupListElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToMultiSelectPopupListElement >> sieve [

	^ selectElement sieve
]

{ #category : #'t - select inner container' }
ToMultiSelectPopupListElement >> updateFromPopupListSelection [
	" rebuild the current bar nodes according to the selection in the popup list "

	| previousDataItems newDataItems |
	selectElement showHidePlaceholder.
	" copy the previous tag models "
	previousDataItems := self dataAccessor asOrderedCollection.
	newDataItems := selectElement selectedDataItems.

	"keepPickOrder ifTrue: [
		newTagModels sort: [ :a :b | a pickOrder < b pickOrder ] ]."

	" if the list has changed then replace all in one datasource command "
	"self dataAccessor asOrderedCollection = newDataItems ifTrue: [ ^ self ]."
	self dataAccessor updateAllWith: newDataItems.
	self checkHideSelectionFromListElement
]
