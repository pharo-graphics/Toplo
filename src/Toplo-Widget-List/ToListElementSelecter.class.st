Class {
	#name : #ToListElementSelecter,
	#superclass : #Object,
	#instVars : [
		'enabled',
		'operator',
		'selectionModel',
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #adding }
ToListElementSelecter >> addCommand: aCommand [

	enabled ifFalse: [ ^ self ].
	operator addCommand: aCommand
]

{ #category : #adding }
ToListElementSelecter >> addSelectionCommand: aCommand [

	aCommand selectionModel: selectionModel.
	self addCommand: aCommand
]

{ #category : #accessing }
ToListElementSelecter >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToListElementSelecter >> beSingleSelection [

	self multiple: false
]

{ #category : #testing }
ToListElementSelecter >> containsIndex: anIndex [

	^ self selectionModel containsIndex: anIndex
]

{ #category : #copying }
ToListElementSelecter >> copySelectionFrom: aSourceSelectionModel [

	self addSelectionCommand: (ToSelectionModelCopyFromCommand new
			 operator: operator;
			 sourceSelectionModel: aSourceSelectionModel;
			 yourself)
]

{ #category : #accessing }
ToListElementSelecter >> currentIndex [

	^ enabled
		  ifFalse: [ 0 ]
		  ifTrue: [ operator currentIndex ]
]

{ #category : #operations }
ToListElementSelecter >> deselectAll [

	self addSelectionCommand: (ToWholeSelectionCommand new
			 operator: operator;
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToListElementSelecter >> deselectIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator:  operator;
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: operator;
			 from: aStartIndex to: anEndIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> deselectIndexes: anArray [

	self addSelectionCommand: (ToIndexesSelectionCommand new
			 operator: operator;
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #protocol }
ToListElementSelecter >> disable [

	self enabled: false
]

{ #category : #protocol }
ToListElementSelecter >> enable [

	self enabled: true
]

{ #category : #protocol }
ToListElementSelecter >> enabled [

	^ enabled
]

{ #category : #protocol }
ToListElementSelecter >> enabled: aBoolean [

	enabled := aBoolean
]

{ #category : #initialization }
ToListElementSelecter >> initialize [ 

	super initialize.
	multiple := true.
	enabled := true
]

{ #category : #testing }
ToListElementSelecter >> isMultipleSelection [

	^ self multiple
]

{ #category : #testing }
ToListElementSelecter >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #accessing }
ToListElementSelecter >> itemCount [

	^ selectionModel itemCount
]

{ #category : #accessing }
ToListElementSelecter >> multiple [

	^ multiple
]

{ #category : #accessing }
ToListElementSelecter >> multiple: aBoolean [

	multiple := aBoolean
]

{ #category : #private }
ToListElementSelecter >> nextDeselectedIndex [

	^ self sideIdx: 1
]

{ #category : #private }
ToListElementSelecter >> nextSelectableIndex [

	enabled ifFalse: [ ^ 0 ].
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
ToListElementSelecter >> nextSelectableIndexStartingAt: anIndex [

	^ selectionModel nextSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToListElementSelecter >> nextSelectableIndexToScrollTo [

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

{ #category : #'api - hooks' }
ToListElementSelecter >> onInstalledIn: anEventTarget [
]

{ #category : #'api - hooks' }
ToListElementSelecter >> onUninstalledIn: anEventTarget [
]

{ #category : #accessing }
ToListElementSelecter >> operator [

	^ operator
]

{ #category : #accessing }
ToListElementSelecter >> operator: aSelectionModelOperator [

	operator := aSelectionModelOperator
]

{ #category : #private }
ToListElementSelecter >> previousDeselectedIndex [

	^ self sideIdx: -1
]

{ #category : #private }
ToListElementSelecter >> previousSelectableIndex [

	enabled ifFalse: [ ^ 0 ].
	self currentIndex isZero
		ifTrue: [
			selectionModel itemCount isZero ifTrue: [ ^ 0 ].
			^ self previousSelectableIndexStartingAt: selectionModel itemCount ]
		ifFalse: [ self currentIndex > (self nextSelectableIndexStartingAt: 1) 
			ifFalse: [ ^ self previousSelectableIndexStartingAt: selectionModel itemCount ] ].
	^ self previousSelectableIndexStartingAt: self currentIndex - 1
]

{ #category : #private }
ToListElementSelecter >> previousSelectableIndexStartingAt: anIndex [

	^ selectionModel previousSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToListElementSelecter >> previousSelectableIndexToScrollTo [

	| prev |
	prev := self previousSelectableIndex.
	" not exactly on the first selectable position -> just return the previous index else, return self itemCount or 0"
	^ self currentIndex > (self nextSelectableIndexStartingAt: 1)
		  ifTrue: [ prev ]
		  ifFalse: [ selectionModel itemCount max: 0 ]
]

{ #category : #operations }
ToListElementSelecter >> scrollToDataSourcePosition: anIndex [

	enabled ifFalse: [ ^ self ].
	selectionModel itemCount >= anIndex ifTrue: [
		self addSelectionCommand: (ToListScrollCommand new
				 operator: operator;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToListElementSelecter >> scrollToIndex: anIndex [

	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndex: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.

	self scrollToDataSourcePosition: anIndex
]

{ #category : #operations }
ToListElementSelecter >> selectAll [

	self isMultipleSelection ifFalse: [ ToInvalidElementCommand signal ].
	self addSelectionCommand: (ToWholeSelectionCommand new
			 operator: operator;
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToListElementSelecter >> selectIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: operator;
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: self isSingleSelection;
					  yourself))
]

{ #category : #operations }
ToListElementSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self isSingleSelection ifTrue: [
		aStartIndex ~= anEndIndex ifTrue: [
			^ ToInvalidElementCommand signal ].
		self selectIndex: aStartIndex.
		^ self ].

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: operator;
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> selectIndexes: anArray [

	anArray ifEmpty: [ ^ self ].

	self isSingleSelection ifTrue: [
		anArray size > 1 ifTrue: [ ^ ToInvalidElementCommand signal ].
		self selectIndex: anArray first.
		^ self ].

	self addSelectionCommand: (ToIndexesSelectionCommand new
			 operator: operator;
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> selectOnlyIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: operator;
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #operations }
ToListElementSelecter >> selectOnlyIndexes: anArray [

	self isSingleSelection ifTrue: [
		anArray size > 1 ifTrue: [ ^ ToInvalidElementCommand signal ] ].

	anArray ifEmpty: [
		self addSelectionCommand: (ToWholeSelectionCommand new
				 operator: operator;
				 operation: ToRemoveSelectionOperation new).
		^ self ].

	self addSelectionCommand: (ToIndexesSelectionCommand new
			 operator: operator;
			 indexes: anArray;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #accessing }
ToListElementSelecter >> selectedIndexes [

	^ self selectionModel selectedIndexes
]

{ #category : #accessing }
ToListElementSelecter >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListElementSelecter >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #operations }
ToListElementSelecter >> shiftSelection: anInteger from: anIndex [

	self addSelectionCommand: (ToSelectionModelShiftCommand new
			 operator: operator;
			 itemCount: anInteger;
			 fromIndex: anIndex;
			 yourself)
]

{ #category : #private }
ToListElementSelecter >> sideIdx: aGap [

	^ enabled ifFalse: [ 0 ] ifTrue: [ selectionModel sideIdx: aGap startingAt: self currentIndex ]
]
