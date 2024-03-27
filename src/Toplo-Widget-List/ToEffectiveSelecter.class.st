Class {
	#name : #ToEffectiveSelecter,
	#superclass : #ToAbstractListElementSelecter,
	#instVars : [
		'operator',
		'selectionModel',
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #adding }
ToEffectiveSelecter >> addCommand: aCommand [

	self operator addCommand: aCommand
]

{ #category : #adding }
ToEffectiveSelecter >> addSelectionCommand: aCommand [

	aCommand selectionModel: selectionModel.
	self addCommand: aCommand
]

{ #category : #accessing }
ToEffectiveSelecter >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToEffectiveSelecter >> beSingleSelection [

	self multiple: false
]

{ #category : #testing }
ToEffectiveSelecter >> containsIndex: anIndex [

	^ self selectionModel containsIndex: anIndex
]

{ #category : #copying }
ToEffectiveSelecter >> copySelectionFrom: aSourceSelectionModel [

	self addSelectionCommand: (ToSelectionModelCopyFromCommand new
			 operator: self operator;
			 sourceSelectionModel: aSourceSelectionModel;
			 yourself)
]

{ #category : #accessing }
ToEffectiveSelecter >> currentIndex [

	^ self operator currentIndex
]

{ #category : #operations }
ToEffectiveSelecter >> deselectAll [

	self addSelectionCommand: (ToWholeSelectionCommand new
			 operator: self operator;
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToEffectiveSelecter >> deselectIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToEffectiveSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: aStartIndex to: anEndIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToEffectiveSelecter >> deselectIndexes: anArray [

	self addSelectionCommand: (ToIndexesSelectionCommand new
			 operator: self operator;
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #initialization }
ToEffectiveSelecter >> initialize [ 

	super initialize.
	multiple := true.
]

{ #category : #testing }
ToEffectiveSelecter >> isMultipleSelection [

	^ self multiple
]

{ #category : #testing }
ToEffectiveSelecter >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #accessing }
ToEffectiveSelecter >> itemCount [

	^ selectionModel itemCount
]

{ #category : #accessing }
ToEffectiveSelecter >> multiple [

	^ multiple
]

{ #category : #accessing }
ToEffectiveSelecter >> multiple: aBoolean [

	multiple := aBoolean
]

{ #category : #private }
ToEffectiveSelecter >> nextDeselectedIndex [

	^ self sideIdx: 1
]

{ #category : #private }
ToEffectiveSelecter >> nextSelectableIndex [

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
ToEffectiveSelecter >> nextSelectableIndexStartingAt: anIndex [

	^ selectionModel nextSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToEffectiveSelecter >> nextSelectableIndexToScrollTo [

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

{ #category : #accessing }
ToEffectiveSelecter >> operator [

	^ operator
]

{ #category : #accessing }
ToEffectiveSelecter >> operator: aSelectionModelOperator [

	operator := aSelectionModelOperator
]

{ #category : #private }
ToEffectiveSelecter >> previousDeselectedIndex [

	^ self sideIdx: -1
]

{ #category : #private }
ToEffectiveSelecter >> previousSelectableIndex [

	self currentIndex isZero
		ifTrue: [
			selectionModel itemCount isZero ifTrue: [ ^ 0 ].
			^ self previousSelectableIndexStartingAt: selectionModel itemCount ]
		ifFalse: [ self currentIndex > (self nextSelectableIndexStartingAt: 1) 
			ifFalse: [ ^ self previousSelectableIndexStartingAt: selectionModel itemCount ] ].
	^ self previousSelectableIndexStartingAt: self currentIndex - 1
]

{ #category : #private }
ToEffectiveSelecter >> previousSelectableIndexStartingAt: anIndex [

	^ selectionModel previousSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToEffectiveSelecter >> previousSelectableIndexToScrollTo [

	| prev |
	prev := self previousSelectableIndex.
	" not exactly on the first selectable position -> just return the previous index else, return self itemCount or 0"
	^ self currentIndex > (self nextSelectableIndexStartingAt: 1)
		  ifTrue: [ prev ]
		  ifFalse: [ selectionModel itemCount max: 0 ]
]

{ #category : #operations }
ToEffectiveSelecter >> scrollToIndex: anIndex [

	selectionModel itemCount >= anIndex ifTrue: [
		self addSelectionCommand: (ToListScrollCommand new
				 operator: self operator;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToEffectiveSelecter >> selectAll [

	self isMultipleSelection ifFalse: [ ToInvalidElementCommand signal ].
	self addSelectionCommand: (ToWholeSelectionCommand new
			 operator: self operator;
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToEffectiveSelecter >> selectIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: self isSingleSelection;
					  yourself))
]

{ #category : #operations }
ToEffectiveSelecter >> selectIndex: aStartIndex to: anEndIndex [

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
ToEffectiveSelecter >> selectIndexes: anArray [

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
ToEffectiveSelecter >> selectOnlyIndex: anIndex [

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
ToEffectiveSelecter >> selectOnlyIndexes: anArray [

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
ToEffectiveSelecter >> selectedIndexes [

	^ self selectionModel selectedIndexes
]

{ #category : #accessing }
ToEffectiveSelecter >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToEffectiveSelecter >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #operations }
ToEffectiveSelecter >> shiftSelection: anInteger from: anIndex [

	self addSelectionCommand: (ToSelectionModelShiftCommand new
			 operator: self operator;
			 itemCount: anInteger;
			 fromIndex: anIndex;
			 yourself)
]

{ #category : #private }
ToEffectiveSelecter >> sideIdx: aGap [

	^ selectionModel sideIdx: aGap startingAt: self currentIndex
]
