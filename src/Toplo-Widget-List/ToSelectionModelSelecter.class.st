Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #ToAbstractSelectionModelSelecter,
	#instVars : [
		'operator'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #adding }
ToSelectionModelSelecter >> addCommand: aCommand [

	self operator addCommand: aCommand
]

{ #category : #copying }
ToSelectionModelSelecter >> copySelectionFrom: aSourceSelectionModel [

	self addCommand: (ToSelectionModelCopyFromCommand new
			 operator: self operator;
			 sourceSelectionModel: aSourceSelectionModel;
			 yourself)
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex [

	^ self operator currentIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operator: self operator;
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: aStartIndex to: anEndIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 operator: self operator;
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
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
			self currentIndex
			< (self previousSelectableIndexStartingAt: self itemCount)
				ifFalse: [ ^ self nextSelectableIndexStartingAt: 1 ] ].
	^ self nextSelectableIndexStartingAt: self currentIndex + 1
]

{ #category : #private }
ToSelectionModelSelecter >> nextSelectableIndexStartingAt: anIndex [

	^ self selectionModel nextSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToSelectionModelSelecter >> nextSelectableIndexToScrollTo [

	| next |
	next := self nextSelectableIndex.
	" not on the last selectable position -> just return the next index else, return 1 or 0"
	^ self currentIndex < (self previousSelectableIndexStartingAt: self selectionModel itemCount)
		  ifTrue: [ next ]
		  ifFalse: [
			  self selectionModel itemCount > 0
				  ifTrue: [ 1 ]
				  ifFalse: [ 0 ] ]
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onUninstalledIn: anEventTarget [

	super onUninstalledIn: anEventTarget.
	operator := nil
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
		ifFalse: [ self currentIndex > (self nextSelectableIndexStartingAt: 1) 
			ifFalse: [ ^ self previousSelectableIndexStartingAt: self itemCount ] ].
	^ self previousSelectableIndexStartingAt: self currentIndex - 1
]

{ #category : #private }
ToSelectionModelSelecter >> previousSelectableIndexStartingAt: anIndex [

	^ self selectionModel previousSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToSelectionModelSelecter >> previousSelectableIndexToScrollTo [

	| prev |
	prev := self previousSelectableIndex.
	" not exactly on the first selectable position -> just return the previous index else, return self itemCount or 0"
	^ self currentIndex > (self nextSelectableIndexStartingAt: 1)
		  ifTrue: [ prev ]
		  ifFalse: [
			  self selectionModel itemCount > 0
				  ifTrue: [ self selectionModel itemCount ]
				  ifFalse: [ 0 ] ]
]

{ #category : #operations }
ToSelectionModelSelecter >> scrollToIndex: anIndex [

	self itemCount >= anIndex ifTrue: [
		self addCommand: (ToListScrollCommand new
				 operator: self operator;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndex: anIndex [

	(self selectionModel selectedIndexesCount = 1 and: [
		 self selectionModel firstIndex = anIndex ]) ifTrue: [ ^ self ].
	self addCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndexes: anArray [

	anArray ifEmpty: [
		self addCommand: (ToWholeSelectionCommand new
				 operator: self operator;
				 operation: ToRemoveSelectionOperation new).
		^ self ].
	self addCommand: (ToIndexesSelectionCommand new
			 operator: self operator;
			 indexes: anArray;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #accessing }
ToSelectionModelSelecter >> selectedIndexes [

	^ self selectionModel selectedIndexes
]

{ #category : #accessing }
ToSelectionModelSelecter >> selectionModel [

	^ self operator selectionModel
]

{ #category : #operations }
ToSelectionModelSelecter >> shiftSelection: anInteger from: anIndex [

	self addCommand: (ToSelectionModelShiftCommand new
			 operator: self operator;
			 itemCount: anInteger;
			 fromIndex: anIndex;
			 yourself)
]

{ #category : #private }
ToSelectionModelSelecter >> sideIdx: aGap [

	^ self selectionModel sideIdx: aGap startingAt: self currentIndex
]
