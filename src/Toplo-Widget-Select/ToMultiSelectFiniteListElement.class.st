Class {
	#name : #ToMultiSelectFiniteListElement,
	#superclass : #ToTagFiniteListElement,
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
ToMultiSelectFiniteListElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #'accessing - selection' }
ToMultiSelectFiniteListElement >> allowSelectedCount: aNumber [

	^ self haveMaxSelectedCount not or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToMultiSelectFiniteListElement >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToMultiSelectFiniteListElement >> checkHideSelectionFromListElement [

	selectElement hideSelected ifFalse: [ ^ self ].
	"self popupListElement inUIProcessDo: [ self popupListElement hideSelection ]"
]

{ #category : #'accessing - selection' }
ToMultiSelectFiniteListElement >> checkMaxSelectedCount [

	| sM disabledSM groupeSM selectedCount |
	self haveMaxSelectedCount ifFalse: [ ^ self ].

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

{ #category : #'accessing - selection' }
ToMultiSelectFiniteListElement >> checkMaxSelectedCountOld [

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
ToMultiSelectFiniteListElement >> defaultInnerElementClass [

	^ ToMultiSelectInnerFiniteListElement
]

{ #category : #initialization }
ToMultiSelectFiniteListElement >> defaultLayout [

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToMultiSelectFiniteListElement >> defaultNodeManagerClass [ 

	^ ToMultiSelectNodeManager
]

{ #category : #layout }
ToMultiSelectFiniteListElement >> extentChanged [

	super extentChanged.
	self updateFromPopupListSelection
]

{ #category : #'t - select inner container' }
ToMultiSelectFiniteListElement >> filterTextField [ 

	^ filterTextField 
]

{ #category : #'t - select inner container' }
ToMultiSelectFiniteListElement >> filterTextField: aTextField [

	filterTextField := aTextField 
]

{ #category : #'accessing - selection' }
ToMultiSelectFiniteListElement >> haveMaxSelectedCount [

	^ maxSelectedCount ~= -1
]

{ #category : #initialization }
ToMultiSelectFiniteListElement >> initialize [

	super initialize.

	" no visible primary and secondary selection elements "
	self selectionOption masked: true.
	self primarySelectionMode makeDisabledUnselectable: true.
	self secondarySelectionMode selectionOption masked: true.
	self focusability: BlFocusability ignore.
	maxSelectedCount := -1.
	keepPickOrder := false.
	pickCount := 0.

	self installFilterTextField
]

{ #category : #accessing }
ToMultiSelectFiniteListElement >> keepPickOrder [

	^ keepPickOrder 
]

{ #category : #accessing }
ToMultiSelectFiniteListElement >> keepPickOrder: aBoolean [

	keepPickOrder := aBoolean.
	self updateFromPopupListSelection
]

{ #category : #accessing }
ToMultiSelectFiniteListElement >> listElement [

	self
		deprecated: 'Use #popupListElement'
		transformWith: '`@rcvr listElement' -> '`@rcvr popupListElement'.

	^ self popupListElement
]

{ #category : #accessing }
ToMultiSelectFiniteListElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
]

{ #category : #accessing }
ToMultiSelectFiniteListElement >> popupListElement [


	^ selectElement popupListElement
]

{ #category : #'accessing - selection' }
ToMultiSelectFiniteListElement >> removeMaxSelectedCount [

	maxSelectedCount := -1
]

{ #category : #'t - select inner container' }
ToMultiSelectFiniteListElement >> selectElement [

	^ selectElement
]

{ #category : #'t - select inner container' }
ToMultiSelectFiniteListElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToMultiSelectFiniteListElement >> sieve [

	^ selectElement sieve
]

{ #category : #'t - select inner container' }
ToMultiSelectFiniteListElement >> updateFromPopupListSelection [
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
