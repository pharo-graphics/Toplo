Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #ToAbstractSelectionModelSelecter,
	#instVars : [
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #adding }
ToSelectionModelSelecter >> addCommand: aCommand [

	self operator addCommand: aCommand
]

{ #category : #adding }
ToSelectionModelSelecter >> addSelectionCommand: aCommand [

	aCommand selectionModel: selectionModel.
	self addCommand: aCommand
]

{ #category : #accessing }
ToSelectionModelSelecter >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToSelectionModelSelecter >> beSingleSelection [

	self multiple: false
]

{ #category : #copying }
ToSelectionModelSelecter >> copySelectionFrom: aSourceSelectionModel [

	self addSelectionCommand: (ToSelectionModelCopyFromCommand new
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

	self addSelectionCommand: (ToWholeSelectionCommand new
			 operator: self operator;
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: aStartIndex to: anEndIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndexes: anArray [

	self addSelectionCommand: (ToIndexesSelectionCommand new
			 operator: self operator;
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #initialization }
ToSelectionModelSelecter >> initialize [ 

	super initialize.
	multiple := true.
]

{ #category : #testing }
ToSelectionModelSelecter >> isMultipleSelection [

	^ self multiple
]

{ #category : #testing }
ToSelectionModelSelecter >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #accessing }
ToSelectionModelSelecter >> itemCount [

	^ selectionModel itemCount
]

{ #category : #accessing }
ToSelectionModelSelecter >> multiple [

	^ multiple
]

{ #category : #accessing }
ToSelectionModelSelecter >> multiple: aBoolean [

	multiple := aBoolean
]

{ #category : #private }
ToSelectionModelSelecter >> nextDeselectedIndex [

	^ self sideIdx: 1
]

{ #category : #private }
ToSelectionModelSelecter >> nextSelectableIndex [

	self currentIndex isZero
		ifTrue: [
			selectionModel itemCount isZero ifTrue: [ ^ 0 ].
			^ self nextSelectableIndexStartingAt: 1 ]
		ifFalse: [
			self currentIndex
			< (self previousSelectableIndexStartingAt: selectionModel itemCount)
				ifFalse: [ ^ self nextSelectableIndexStartingAt: 1 ] ].
	^ self nextSelectableIndexStartingAt: self currentIndex + 1
]

{ #category : #private }
ToSelectionModelSelecter >> nextSelectableIndexStartingAt: anIndex [

	^ selectionModel nextSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToSelectionModelSelecter >> nextSelectableIndexToScrollTo [

	| next |
	next := self nextSelectableIndex.
	" not on the last selectable position -> just return the next index else, return 1 or 0"
	^ self currentIndex < (self previousSelectableIndexStartingAt: selectionModel itemCount)
		  ifTrue: [ next ]
		  ifFalse: [
			  selectionModel itemCount > 0
				  ifTrue: [ 1 ]
				  ifFalse: [ 0 ] ]
]

{ #category : #private }
ToSelectionModelSelecter >> previousDeselectedIndex [

	^ self sideIdx: -1
]

{ #category : #private }
ToSelectionModelSelecter >> previousSelectableIndex [

	self currentIndex isZero
		ifTrue: [
			selectionModel itemCount isZero ifTrue: [ ^ 0 ].
			^ self previousSelectableIndexStartingAt: selectionModel itemCount ]
		ifFalse: [ self currentIndex > (self nextSelectableIndexStartingAt: 1) 
			ifFalse: [ ^ self previousSelectableIndexStartingAt: selectionModel itemCount ] ].
	^ self previousSelectableIndexStartingAt: self currentIndex - 1
]

{ #category : #private }
ToSelectionModelSelecter >> previousSelectableIndexStartingAt: anIndex [

	^ selectionModel previousSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToSelectionModelSelecter >> previousSelectableIndexToScrollTo [

	| prev |
	prev := self previousSelectableIndex.
	" not exactly on the first selectable position -> just return the previous index else, return self itemCount or 0"
	^ self currentIndex > (self nextSelectableIndexStartingAt: 1)
		  ifTrue: [ prev ]
		  ifFalse: [ selectionModel itemCount max: 0 ]
]

{ #category : #operations }
ToSelectionModelSelecter >> scrollToIndex: anIndex [

	selectionModel itemCount >= anIndex ifTrue: [
		self addSelectionCommand: (ToListScrollCommand new
				 operator: self operator;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToSelectionModelSelecter >> selectAll [

	self isMultipleSelection ifFalse: [ ToInvalidElementCommand signal ].
	self addSelectionCommand: (ToWholeSelectionCommand new
			 operator: self operator;
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: self isSingleSelection;
					  yourself))
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self isSingleSelection ifTrue: [
		aStartIndex ~= anEndIndex ifTrue: [
			^ ToInvalidElementCommand signal ].
		self selectIndex: aStartIndex.
		^ self ].

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndexes: anArray [

	anArray ifEmpty: [ ^ self ].

	self isSingleSelection ifTrue: [
		anArray size > 1 ifTrue: [ ^ ToInvalidElementCommand signal ].
		self selectIndex: anArray first.
		^ self ].

	self addSelectionCommand: (ToIndexesSelectionCommand new
			 operator: self operator;
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndex: anIndex [

	(selectionModel selectedIndexesCount = 1 and: [
		 selectionModel firstIndex = anIndex ]) ifTrue: [ ^ self ].
	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndexes: anArray [

	self isSingleSelection ifTrue: [
		anArray size > 1 ifTrue: [ ^ ToInvalidElementCommand signal ] ].

	anArray ifEmpty: [
		self addSelectionCommand: (ToWholeSelectionCommand new
				 operator: self operator;
				 operation: ToRemoveSelectionOperation new).
		^ self ].

	self addSelectionCommand: (ToIndexesSelectionCommand new
			 operator: self operator;
			 indexes: anArray;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #accessing }
ToSelectionModelSelecter >> selectedIndexes [

	^ selectionModel selectedIndexes
]

{ #category : #operations }
ToSelectionModelSelecter >> shiftSelection: anInteger from: anIndex [

	self addSelectionCommand: (ToSelectionModelShiftCommand new
			 operator: self operator;
			 itemCount: anInteger;
			 fromIndex: anIndex;
			 yourself)
]

{ #category : #private }
ToSelectionModelSelecter >> sideIdx: aGap [

	^ selectionModel sideIdx: aGap startingAt: self currentIndex
]
