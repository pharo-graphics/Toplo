Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #ToAbstractSelectionModelSelecter,
	#instVars : [
		'currentIndex',
		'operator',
		'operateSilently',
		'unselectableSelectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #adding }
ToSelectionModelSelecter >> addCommand: aCommand [

	aCommand silent ifFalse: [aCommand silent: self operateSilently ].
	self operator addCommand: aCommand
]

{ #category : #accessing }
ToSelectionModelSelecter >> beSilentWhile: aBlock [

	| prev |
	prev := operateSilently.
	operateSilently := true.
	[ aBlock cull: self ] ensure: [ operateSilently := prev ] 
]

{ #category : #operations }
ToSelectionModelSelecter >> changeCurrentIndexWith: anIndex [

	self currentIndex: anIndex
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself).
	self changeCurrentIndexWith: 0
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToRemoveSelectionOperation new).
	self changeCurrentIndexWith: (aStartIndex min: anEndIndex)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new).
	self changeCurrentIndexWith: 0
]

{ #category : #accessing }
ToSelectionModelSelecter >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #private }
ToSelectionModelSelecter >> nextDeselectedIndex [

	^ self sideIdx: 1
]

{ #category : #private }
ToSelectionModelSelecter >> nextSelectableIndex [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ 0 ].
			^ self nextSelectableIndexStartingAt: 1 ]
		ifFalse: [
			self currentIndex < self itemCount ifFalse: [
				^ self nextSelectableIndexStartingAt: 1 ] ].
	^ self nextSelectableIndexStartingAt: self currentIndex + 1
]

{ #category : #private }
ToSelectionModelSelecter >> nextSelectableIndexStartingAt: anIndex [

	anIndex to: unselectableSelectionModel itemCount do: [ :idx |
		(unselectableSelectionModel containsIndex: idx) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	unselectableSelectionModel := anEventTarget unselectableSelectionModel.
	currentIndex := 0
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onUninstalledIn: anEventTarget [

	super onUninstalledIn: anEventTarget.
	operator := nil.
	currentIndex := 0.
	unselectableSelectionModel := nil
]

{ #category : #accessing }
ToSelectionModelSelecter >> operateSilently [

	^ operateSilently 
]

{ #category : #accessing }
ToSelectionModelSelecter >> operator [

	^ operator
]

{ #category : #accessing }
ToSelectionModelSelecter >> operator: anOperator [

	operator := anOperator
]

{ #category : #private }
ToSelectionModelSelecter >> previousDeselectedIndex [

	^ self sideIdx: -1
]

{ #category : #private }
ToSelectionModelSelecter >> previousSelectableIndex [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ 0 ].
			^ self previousSelectableIndexStartingAt: self itemCount ]
		ifFalse: [ self currentIndex > 1 ifFalse: [ ^ self previousSelectableIndexStartingAt: self itemCount ] ].
	^ self previousSelectableIndexStartingAt: self currentIndex - 1
]

{ #category : #private }
ToSelectionModelSelecter >> previousSelectableIndexStartingAt: anIndex [

	anIndex to: 1 by: -1 do: [ :idx |
		(unselectableSelectionModel containsIndex: idx) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #operations }
ToSelectionModelSelecter >> scrollToIndex: anIndex [

	self itemCount >= anIndex ifTrue: [
		self addCommand: (ToListScrollCommand new
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndex: anIndex [

	(self selectionModel selectedIndexesCount = 1 and: [
		 self selectionModel firstIndex = anIndex ]) ifTrue: [ ^ self ].
	self addCommand: (ToCompositeCommand new commands: {
				 (ToWholeSelectionCommand new
					  silent: true;
					  operation: ToRemoveSelectionOperation new;
					  yourself).
				 (ToIntervalSelectionCommand new
					  from: anIndex to: anIndex;
					  operation: ToAddSelectionOperation new) }).
	self changeCurrentIndexWith: anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndexes: anArray [

	anArray ifEmpty: [ 
		self addCommand:
			(ToWholeSelectionCommand new operation:
				 ToRemoveSelectionOperation new).
		self changeCurrentIndexWith: 0.
		^ self ].
	self addCommand: (ToCompositeCommand new commands: {
				 (ToWholeSelectionCommand new
					  silent: true;
					  operation: ToRemoveSelectionOperation new).
				 (ToIndexesSelectionCommand new
					  indexes: anArray;
					  operation: ToAddSelectionOperation new) }).
	self changeCurrentIndexWith: anArray last
]

{ #category : #accessing }
ToSelectionModelSelecter >> selectionModel [

	^ self operator selectionModel
]

{ #category : #operations }
ToSelectionModelSelecter >> shiftSelection: anInteger from: anIndex [

	self addCommand: (ToSelectionModelShiftCommand new
			 itemCount: anInteger;
			 fromIndex: anIndex;
			 yourself)
]

{ #category : #private }
ToSelectionModelSelecter >> sideIdx: aGap [

	| nextIdx |
	nextIdx := self currentIndex.
	(self selectionModel containsIndex: nextIdx) ifFalse: [
		^ aGap < 0
			  ifTrue: [ self previousSelectableIndexStartingAt: nextIdx ]
			  ifFalse: [ self nextSelectableIndexStartingAt: nextIdx ] ].
	[
	(nextIdx between: 1 and: self itemCount) and: [
		(self selectionModel containsIndex: nextIdx) or: [
			unselectableSelectionModel containsIndex: nextIdx ] ] ] whileTrue: [
		nextIdx := nextIdx + aGap ].
	nextIdx := (nextIdx max: 1) min: self itemCount.

	^ (unselectableSelectionModel containsIndex: nextIdx)
		  ifTrue: [ 0 ]
		  ifFalse: [ nextIdx ]
]
