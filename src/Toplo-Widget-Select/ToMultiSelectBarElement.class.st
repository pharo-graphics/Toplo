Class {
	#name : #ToMultiSelectBarElement,
	#superclass : #ToGenericBarElement,
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

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> checkMaxSelectedCountOld [

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
ToMultiSelectBarElement >> defaultInnerElementClass [

	^ ToMultiSelectInnerBarElement
]

{ #category : #initialization }
ToMultiSelectBarElement >> defaultLayout [

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToMultiSelectBarElement >> defaultNodeManagerClass [ 

	^ ToMultiSelectNodeManager
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

{ #category : #initialization }
ToMultiSelectBarElement >> initialize [

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

	maxSelectedCount := aNumber
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

	| previousDataItems newDataItems |
	selectElement showHidePlaceholder.
	" copy the previous tag models "
	previousDataItems := self dataAccessor asOrderedCollection.
	newDataItems := OrderedCollection new.

	" reconstruct the item list. ensure the reuse of pre-existing items"
	selectElement selectionModel selectedIndexesDo: [ :idx |
		| new previous dataItem |
		dataItem := selectElement sieve originalData at: idx.
		newDataItems add: dataItem ].

	"keepPickOrder ifTrue: [
		newTagModels sort: [ :a :b | a pickOrder < b pickOrder ] ]."

	" if the list has changed then replace all in one datasource command "
	"self dataAccessor asOrderedCollection = newDataItems ifTrue: [ ^ self ]."
	self dataAccessor updateAllWith: newDataItems.
	self checkHideSelectionFromListElement
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
