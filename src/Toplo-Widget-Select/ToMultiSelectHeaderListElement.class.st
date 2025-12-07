Class {
	#name : #ToMultiSelectHeaderListElement,
	#superclass : #ToGenericFiniteListElement,
	#traits : 'TToSelectHeaderElement + TToElementWithPlaceholder',
	#classTraits : 'TToSelectHeaderElement classTrait + TToElementWithPlaceholder classTrait',
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
ToMultiSelectHeaderListElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> allowSelectedCount: aNumber [

	^ self haveMaxSelectedCount not or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> checkHideSelectionFromListElement [

	selectElement hideSelected ifFalse: [ ^ self ].
	self popupListElement inUIProcessDo: [ self popupListElement hideSelection ]
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> checkMaxSelectedCount [

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
ToMultiSelectHeaderListElement >> checkMaxSelectedCountOld [

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
ToMultiSelectHeaderListElement >> defaultInnerElementClass [

	^ ToMultiSelectHeaderInnerListElement
]

{ #category : #initialization }
ToMultiSelectHeaderListElement >> defaultLayout [

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToMultiSelectHeaderListElement >> defaultNodeManagerClass [ 

	^ ToMultiSelectHeaderNodeManager
]

{ #category : #layout }
ToMultiSelectHeaderListElement >> extentChanged [

	super extentChanged.
	self updateFromPopupListSelection
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderListElement >> filterTextField [ 

	^ filterTextField 
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderListElement >> filterTextField: aTextField [

	filterTextField := aTextField 
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> haveMaxSelectedCount [

	^ maxSelectedCount ~= -1
]

{ #category : #initialization }
ToMultiSelectHeaderListElement >> initialize [

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
ToMultiSelectHeaderListElement >> keepPickOrder [

	^ keepPickOrder 
]

{ #category : #accessing }
ToMultiSelectHeaderListElement >> keepPickOrder: aBoolean [

	keepPickOrder := aBoolean.
	self updateFromPopupListSelection
]

{ #category : #accessing }
ToMultiSelectHeaderListElement >> listElement [

	self
		deprecated: 'Use #popupListElement'
		transformWith: '`@rcvr listElement' -> '`@rcvr popupListElement'.

	^ self popupListElement
]

{ #category : #accessing }
ToMultiSelectHeaderListElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
]

{ #category : #accessing }
ToMultiSelectHeaderListElement >> popupListElement [


	^ selectElement popupListElement
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderListElement >> refreshFromPopupListSelection [
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
ToMultiSelectHeaderListElement >> removeMaxSelectedCount [

	maxSelectedCount := -1
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderListElement >> selectElement [

	^ selectElement
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderListElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToMultiSelectHeaderListElement >> sieve [

	^ selectElement sieve
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderListElement >> updateFromPopupListSelection [
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
