Class {
	#name : #ToEffectiveSelectionModelSelecter,
	#superclass : #ToAbstractSelectionModelSelecter,
	#instVars : [
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #adding }
ToEffectiveSelectionModelSelecter >> addCommand: aCommand [

	self operator addCommand: aCommand
]

{ #category : #adding }
ToEffectiveSelectionModelSelecter >> addSelectionCommand: aCommand [

	aCommand selectionModel: selectionModel.
	self addCommand: aCommand
]

{ #category : #accessing }
ToEffectiveSelectionModelSelecter >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToEffectiveSelectionModelSelecter >> beSingleSelection [

	self multiple: false
]

{ #category : #copying }
ToEffectiveSelectionModelSelecter >> copySelectionFrom: aSourceSelectionModel [

	self addSelectionCommand: (ToSelectionModelCopyFromCommand new
			 operator: self operator;
			 sourceSelectionModel: aSourceSelectionModel;
			 yourself)
]

{ #category : #accessing }
ToEffectiveSelectionModelSelecter >> currentIndex [

	^ self operator currentIndex
]

{ #category : #operations }
ToEffectiveSelectionModelSelecter >> deselectAll [

	self addSelectionCommand: (ToWholeSelectionCommand new
			 operator: self operator;
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToEffectiveSelectionModelSelecter >> deselectIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToEffectiveSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: aStartIndex to: anEndIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToEffectiveSelectionModelSelecter >> deselectIndexes: anArray [

	self addSelectionCommand: (ToIndexesSelectionCommand new
			 operator: self operator;
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #initialization }
ToEffectiveSelectionModelSelecter >> initialize [ 

	super initialize.
	multiple := true.
]

{ #category : #testing }
ToEffectiveSelectionModelSelecter >> isMultipleSelection [

	^ self multiple
]

{ #category : #testing }
ToEffectiveSelectionModelSelecter >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #accessing }
ToEffectiveSelectionModelSelecter >> itemCount [

	^ selectionModel itemCount
]

{ #category : #accessing }
ToEffectiveSelectionModelSelecter >> multiple [

	^ multiple
]

{ #category : #accessing }
ToEffectiveSelectionModelSelecter >> multiple: aBoolean [

	multiple := aBoolean
]

{ #category : #private }
ToEffectiveSelectionModelSelecter >> nextDeselectedIndex [

	^ self sideIdx: 1
]

{ #category : #private }
ToEffectiveSelectionModelSelecter >> nextSelectableIndex [

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
ToEffectiveSelectionModelSelecter >> nextSelectableIndexStartingAt: anIndex [

	^ selectionModel nextSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToEffectiveSelectionModelSelecter >> nextSelectableIndexToScrollTo [

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
ToEffectiveSelectionModelSelecter >> previousDeselectedIndex [

	^ self sideIdx: -1
]

{ #category : #private }
ToEffectiveSelectionModelSelecter >> previousSelectableIndex [

	self currentIndex isZero
		ifTrue: [
			selectionModel itemCount isZero ifTrue: [ ^ 0 ].
			^ self previousSelectableIndexStartingAt: selectionModel itemCount ]
		ifFalse: [ self currentIndex > (self nextSelectableIndexStartingAt: 1) 
			ifFalse: [ ^ self previousSelectableIndexStartingAt: selectionModel itemCount ] ].
	^ self previousSelectableIndexStartingAt: self currentIndex - 1
]

{ #category : #private }
ToEffectiveSelectionModelSelecter >> previousSelectableIndexStartingAt: anIndex [

	^ selectionModel previousSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToEffectiveSelectionModelSelecter >> previousSelectableIndexToScrollTo [

	| prev |
	prev := self previousSelectableIndex.
	" not exactly on the first selectable position -> just return the previous index else, return self itemCount or 0"
	^ self currentIndex > (self nextSelectableIndexStartingAt: 1)
		  ifTrue: [ prev ]
		  ifFalse: [ selectionModel itemCount max: 0 ]
]

{ #category : #operations }
ToEffectiveSelectionModelSelecter >> scrollToIndex: anIndex [

	selectionModel itemCount >= anIndex ifTrue: [
		self addSelectionCommand: (ToListScrollCommand new
				 operator: self operator;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToEffectiveSelectionModelSelecter >> selectAll [

	self isMultipleSelection ifFalse: [ ToInvalidElementCommand signal ].
	self addSelectionCommand: (ToWholeSelectionCommand new
			 operator: self operator;
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToEffectiveSelectionModelSelecter >> selectIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: self isSingleSelection;
					  yourself))
]

{ #category : #operations }
ToEffectiveSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

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
ToEffectiveSelectionModelSelecter >> selectIndexes: anArray [

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
ToEffectiveSelectionModelSelecter >> selectOnlyIndex: anIndex [

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
ToEffectiveSelectionModelSelecter >> selectOnlyIndexes: anArray [

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
ToEffectiveSelectionModelSelecter >> selectedIndexes [

	^ selectionModel selectedIndexes
]

{ #category : #operations }
ToEffectiveSelectionModelSelecter >> shiftSelection: anInteger from: anIndex [

	self addSelectionCommand: (ToSelectionModelShiftCommand new
			 operator: self operator;
			 itemCount: anInteger;
			 fromIndex: anIndex;
			 yourself)
]

{ #category : #private }
ToEffectiveSelectionModelSelecter >> sideIdx: aGap [

	^ selectionModel sideIdx: aGap startingAt: self currentIndex
]
