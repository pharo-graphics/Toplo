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
		'filterTextField',
		'selectedItemIndex',
		'invisibleNodesCommentElement'
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
	selectedItemIndex := IdentityDictionary new.
	maxSelectedCount := -1.
	keepPickOrder := false.
	pickCount := 0.

	self installFilterTextField.
	self installInvisibleNodesComment
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> installInvisibleNodesComment [

	self invisibleNodesCommentElement: ToMultiSelectHeaderInvisibleNodesCommentElement new.
	self addChild: self invisibleNodesCommentElement before: self filterTextField
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> invisibleNodesCommentElement [

	^ invisibleNodesCommentElement
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> invisibleNodesCommentElement: aCommentElement [ 

	invisibleNodesCommentElement ifNotNil: [ (BlImmutableObjectChangeError object: self) signal  ].
	invisibleNodesCommentElement := aCommentElement
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
ToMultiSelectHeaderListElement >> selectedDataItems [

	^ self innerElement selectedDataItems
]

{ #category : #accessing }
ToMultiSelectHeaderListElement >> sieve [

	^ selectElement sieve
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderListElement >> updateFromPopupListSelection [
	" rebuild the current nodes according to the selection in the popup list "

	| currentItems |
	selectElement showHidePlaceholder.
	currentItems := selectElement selectedDataItems.

	keepPickOrder ifTrue: [ " sort the selected items according to pickCount "
			| reselected newlySelected previousItems deselected assocs |
			previousItems := selectedItemIndex keys.
			reselected := previousItems select: [ :item |
				              currentItems includes: item ].
			deselected := previousItems reject: [ :item |
				              currentItems includes: item ].
			newlySelected := currentItems difference: reselected.
			newlySelected do: [ :item |
					pickCount := pickCount + 1.
					selectedItemIndex at: item put: pickCount ].
			deselected do: [ :item | selectedItemIndex removeKey: item ].
			assocs := selectedItemIndex associations.
			assocs sort: [ :a :b |
				(selectedItemIndex at: a key) < (selectedItemIndex at: b key) ].
			currentItems := assocs collect: [ :a | a key ] ].

	self dataAccessor updateAllWith: currentItems.
	self checkHideSelectionFromListElement
]
