Class {
	#name : #ToListElementSelecter,
	#superclass : #ToSelectionModelOperator,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'target',
		'currentIndex'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #operations }
ToListElementSelecter >> addCommand: aCommand [

	super addCommand: aCommand.
	self target dispatchEvent: (ToSelectionCommandAddedEvent new
			 command: aCommand;
			 yourself)
]

{ #category : #'applied command handling' }
ToListElementSelecter >> addIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ self currentIndex: 0 ] ifNotEmpty: [ :indexes | self currentIndex: indexes first ]
]

{ #category : #'applied command handling' }
ToListElementSelecter >> addIntervalSelectionCommand: aCommand [

	self currentIndex: aCommand to
]

{ #category : #'applied command handling' }
ToListElementSelecter >> addSelectionHolderCommand: aCommand [

	aCommand action cull: self target
]

{ #category : #'applied command handling' }
ToListElementSelecter >> addWholeSelectionCommand: aCommand [

	self currentIndex: 0
]

{ #category : #'command application' }
ToListElementSelecter >> apply [

	self applyOn: self target
]

{ #category : #accessing }
ToListElementSelecter >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToListElementSelecter >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #initialization }
ToListElementSelecter >> initialize [ 

	super initialize.
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

{ #category : #'api - hooks' }
ToListElementSelecter >> onInstalledIn: anEventTarget [

	self target: anEventTarget
]

{ #category : #'api - hooks' }
ToListElementSelecter >> onUninstalledIn: anEventTarget [

	self target: nil.

	

]

{ #category : #'applied command handling' }
ToListElementSelecter >> removeIndexesSelectionCommand: aCommand [

	self currentIndex: aCommand indexes first
]

{ #category : #'applied command handling' }
ToListElementSelecter >> removeIntervalSelectionCommand: aCommand [

	self currentIndex: aCommand to
]

{ #category : #'applied command handling' }
ToListElementSelecter >> removeWholeSelectionCommand: aCommand [

	self currentIndex: 0
]

{ #category : #operations }
ToListElementSelecter >> selectAndScrollToIndex: anIndex [

	self selectIndex: anIndex.
	self addCommand: (ToActionCommand new
			 action: [ :e |
				 e selectionModel ifNotEmpty: [ e scrollToIndex: anIndex ] ];
			 yourself)
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

{ #category : #accessing }
ToListElementSelecter >> target [

	^ target
]

{ #category : #accessing }
ToListElementSelecter >> target: anEventTarget [

	target := anEventTarget
]
