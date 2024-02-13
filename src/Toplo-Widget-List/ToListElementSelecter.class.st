Class {
	#name : #ToListElementSelecter,
	#superclass : #ToCommandOperator,
	#instVars : [
		'currentIndex',
		'operateSilently'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #'command operations' }
ToListElementSelecter >> addIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel selectAllIndexes: aCommand indexes.
	aCommand indexes
		ifEmpty: [ self currentIndex: 0 ]
		ifNotEmpty: [ :indexes | self currentIndex: indexes first ]
]

{ #category : #'command operations' }
ToListElementSelecter >> addIntervalSelectionCommand: aCommand [

	| from to |
	from := aCommand from min: aCommand to.
	to := aCommand from max: aCommand to.
	self selectionModel selectIndex: from to: to.
	self currentIndex: aCommand to
]

{ #category : #'command operations' }
ToListElementSelecter >> addWholeSelectionCommand: aCommand [

	self selectionModel selectAll.
	self currentIndex: 0
]

{ #category : #'command application' }
ToListElementSelecter >> apply [

	| previousModel changed |
	previousModel := self selectionModel copy.
	command applyOn: self.
	changed := previousModel ~= self selectionModel.
	operateSilently ifTrue: [ ^ self ].
	
	self target dispatchEvent: (ToSelectionCommandAppliedEvent new
			 commandTarget: self;
			 command: command).
			
	changed ifFalse: [ ^ self ].
	self target dispatchEvent: (ToListSelectionChangedEvent new
			 selectionModel: self selectionModel copy;
			 yourself)
]

{ #category : #'event dispatching' }
ToListElementSelecter >> beSilentWhile: aBlock [

	| prev | 
	prev := operateSilently.
	operateSilently := false.
	aBlock ensure: [ operateSilently := prev ]
]

{ #category : #accessing }
ToListElementSelecter >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToListElementSelecter >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #operations }
ToListElementSelecter >> deselectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToListElementSelecter >> deselectAllIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> deselectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #initialization }
ToListElementSelecter >> initialize [ 

	super initialize.
	operateSilently := false.
	currentIndex := 0
]

{ #category : #accessing }
ToListElementSelecter >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #private }
ToListElementSelecter >> nextIdxTowardEnd [ 

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
ToListElementSelecter >> nextIdxTowardStart [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ 0 ].
			^ self itemCount ]
		ifFalse: [ self currentIndex > 1 ifFalse: [ ^ self itemCount ] ].
	^ self currentIndex - 1
]

{ #category : #'command operations' }
ToListElementSelecter >> removeIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel deselectAllIndexes: aCommand indexes.
	self currentIndex: aCommand indexes first
]

{ #category : #'command operations' }
ToListElementSelecter >> removeIntervalSelectionCommand: aCommand [

	self selectionModel deselectIndex: aCommand from to: aCommand to.
	self currentIndex: aCommand to
]

{ #category : #'command operations' }
ToListElementSelecter >> removeWholeSelectionCommand: aCommand [

	self selectionModel deselectAll.
	self currentIndex: 0
]

{ #category : #operations }
ToListElementSelecter >> selectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToListElementSelecter >> selectAllIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> selectAndScrollToIndex: anIndex [

	self selectIndex: anIndex.
	self selectionModel ifNotEmpty: [ self target scrollToIndex: anIndex ]
]

{ #category : #'shortcuts operations' }
ToListElementSelecter >> selectAndScrollToNext [

	| nextIdx |
	nextIdx := self nextIdxTowardEnd.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToListElementSelecter >> selectAndScrollToNextDeselected [

	self selectAndScrollToIndex: (self sideIdx: 1)
]

{ #category : #'shortcuts operations' }
ToListElementSelecter >> selectAndScrollToPrevious [

	| nextIdx |
	nextIdx := self nextIdxTowardStart.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToListElementSelecter >> selectAndScrollToPreviousDeselected [

	self selectAndScrollToIndex: (self sideIdx: -1)
]

{ #category : #operations }
ToListElementSelecter >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> selectOnlyIndex: anIndex [

	self addCommand: ((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIntervalSelectionCommand new
				  from: anIndex to: anIndex;
				  operation: ToAddSelectionOperation new))
]

{ #category : #operations }
ToListElementSelecter >> selectOnlyIndexes: anArray [

	self addCommand: ((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIndexesSelectionCommand new
				  indexes: anArray;
				  operation: ToAddSelectionOperation new))
]

{ #category : #'shortcuts operations' }
ToListElementSelecter >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self selectIndex: curr to: index
]

{ #category : #accessing }
ToListElementSelecter >> selectionModel [

	^ self target selectionModel
]

{ #category : #private }
ToListElementSelecter >> sideIdx: aGap [

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
