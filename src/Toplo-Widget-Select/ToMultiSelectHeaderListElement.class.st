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
		'invisibleNodesLabel'
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
	maxSelectedCount := -1.
	keepPickOrder := false.
	pickCount := 0.

	self installFilterTextField.
	self installInvisibleNodesLabel
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> installInvisibleNodesLabel [

	| pane |
	self invisibleNodesLabel: ToLabel new.
	self invisibleNodesLabel constraintsDo: [ :c |
		c linear vertical alignCenter ].
	pane := ToPane new
		        fitContent;
		        yourself.
	pane margin: (BlInsets right: 4).
	pane elevation: (BlRelativeElevation elevation: 16).
	pane constraintsDo: [ :c |
			c linear vertical alignCenter.
			c flow vertical alignCenter ].
	pane addChild: self invisibleNodesLabel.
	self addChild: pane before: self filterTextField
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> invisibleNodesLabel [

	^ invisibleNodesLabel
]

{ #category : #'accessing - selection' }
ToMultiSelectHeaderListElement >> invisibleNodesLabel: aLabel [ 

	invisibleNodesLabel ifNotNil: [ (BlImmutableObjectChangeError object: self) signal  ].
	invisibleNodesLabel := aLabel
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
ToMultiSelectHeaderListElement >> sieve [

	^ selectElement sieve
]

{ #category : #'t - select inner container' }
ToMultiSelectHeaderListElement >> updateFromPopupListSelection [
	" rebuild the current nodes according to the selection in the popup list "

	| newDataItems |
	selectElement showHidePlaceholder.
	newDataItems := selectElement selectedDataItems.
	self dataAccessor updateAllWith: newDataItems.
	self checkHideSelectionFromListElement
]
