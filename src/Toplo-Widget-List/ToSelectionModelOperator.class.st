Class {
	#name : #ToSelectionModelOperator,
	#superclass : #ToCommandTarget,
	#instVars : [
		'currentIndex',
		'operateSilently',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel selectAllIndexes: aCommand indexes.
	aCommand indexes
		ifEmpty: [ self currentIndex: 0 ]
		ifNotEmpty: [ :indexes | self currentIndex: indexes first ]
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addIntervalSelectionCommand: aCommand [

	| from to |
	from := aCommand from min: aCommand to.
	to := aCommand from max: aCommand to.
	self selectionModel selectIndex: from to: to.
	self currentIndex: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addWholeSelectionCommand: aCommand [

	self selectionModel selectAll.
	self currentIndex: 0
]

{ #category : #'command application' }
ToSelectionModelOperator >> applyCommand: aCommand for: aTarget [

	| previousModel changed |
	previousModel := self selectionModel copy.
	
	super applyCommand: aCommand for: aTarget.
	
	changed := previousModel ~= self selectionModel.
	operateSilently ifTrue: [ ^ self ].
	
	self dispatchEvent: (ToSelectionCommandAppliedEvent new
			 operator: self;
			 command: aCommand).
			
	changed ifFalse: [ ^ self ].
	self dispatchEvent: (ToListSelectionChangedEvent new
			 selectionModel: self selectionModel copy;
			 yourself)
]

{ #category : #'event dispatching' }
ToSelectionModelOperator >> beSilentWhile: aBlock [

	| prev | 
	prev := operateSilently.
	operateSilently := false.
	aBlock ensure: [ operateSilently := prev ]
]

{ #category : #accessing }
ToSelectionModelOperator >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToSelectionModelOperator >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #operations }
ToSelectionModelOperator >> deselectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelOperator >> deselectAllIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> deselectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #initialization }
ToSelectionModelOperator >> initialize [ 

	super initialize.
	operateSilently := false.
	currentIndex := 0
]

{ #category : #accessing }
ToSelectionModelOperator >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #private }
ToSelectionModelOperator >> nextIdxTowardEnd [ 

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ 0 ].
			^ 1 ]
		ifFalse: [
			self currentIndex < self itemCount ifFalse: [
				^  1 ] ].
	^ self currentIndex + 1
]

{ #category : #private }
ToSelectionModelOperator >> nextIdxTowardStart [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ 0 ].
			^ self itemCount ]
		ifFalse: [ self currentIndex > 1 ifFalse: [ ^ self itemCount ] ].
	^ self currentIndex - 1
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel deselectAllIndexes: aCommand indexes.
	self currentIndex: aCommand indexes first
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIntervalSelectionCommand: aCommand [

	self selectionModel deselectIndex: aCommand from to: aCommand to.
	self currentIndex: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeWholeSelectionCommand: aCommand [

	self selectionModel deselectAll.
	self currentIndex: 0
]

{ #category : #operations }
ToSelectionModelOperator >> selectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelOperator >> selectAllIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> selectAndScrollToIndex: anIndex [

	self selectIndex: anIndex.
	self applyAll.
	self selectionModel ifNotEmpty: [
		self addCommand: (ToActionCommand new
				 action: [ :e | e scrollToIndex: anIndex ];
				 yourself) ]
]

{ #category : #'shortcuts operations' }
ToSelectionModelOperator >> selectAndScrollToNext [

	| nextIdx |
	nextIdx := self nextIdxTowardEnd.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self applyAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToSelectionModelOperator >> selectAndScrollToNextDeselected [

	self selectAndScrollToIndex: (self sideIdx: 1)
]

{ #category : #'shortcuts operations' }
ToSelectionModelOperator >> selectAndScrollToPrevious [

	| nextIdx |
	nextIdx := self nextIdxTowardStart.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToSelectionModelOperator >> selectAndScrollToPreviousDeselected [

	self selectAndScrollToIndex: (self sideIdx: -1)
]

{ #category : #operations }
ToSelectionModelOperator >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> selectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> selectOnlyIndex: anIndex [

	self addCommand: ((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIntervalSelectionCommand new
				  from: anIndex to: anIndex;
				  operation: ToAddSelectionOperation new))
]

{ #category : #operations }
ToSelectionModelOperator >> selectOnlyIndexes: anArray [

	self addCommand: ((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIndexesSelectionCommand new
				  indexes: anArray;
				  operation: ToAddSelectionOperation new))
]

{ #category : #'shortcuts operations' }
ToSelectionModelOperator >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self selectIndex: curr to: index
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToSelectionModelOperator >> sharedEvents [

	^ super sharedEvents , {
		  ToSelectionCommandAppliedEvent.
		  ToListSelectionChangedEvent }
]

{ #category : #private }
ToSelectionModelOperator >> sideIdx: aGap [

	| nextIdx |
	nextIdx := self currentIndex.
	(self selectionModel containsIndex: nextIdx) ifFalse: [ ^ nextIdx ].
	[
	(nextIdx between: 1 and: self itemCount) and: [
		self selectionModel containsIndex: nextIdx ] ] whileTrue: [
		nextIdx := nextIdx + aGap ].
	nextIdx := (nextIdx max: 1) min: self itemCount.
	^ nextIdx
]
