Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #ToSelectionModelOperator,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'target',
		'currentIndex'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #operations }
ToSelectionModelSelecter >> addCommand: aCommand [

	super addCommand: aCommand.
	self target dispatchEvent: (ToSelectionCommandAddedEvent new
			 command: aCommand;
			 yourself)
]

{ #category : #'applied command handling' }
ToSelectionModelSelecter >> addIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ self currentIndex: 0 ] ifNotEmpty: [ :indexes | self currentIndex: indexes first ]
]

{ #category : #'applied command handling' }
ToSelectionModelSelecter >> addIntervalSelectionCommand: aCommand [

	self currentIndex: aCommand to
]

{ #category : #'applied command handling' }
ToSelectionModelSelecter >> addSelectionHolderCommand: aCommand [

	aCommand action cull: self target
]

{ #category : #'applied command handling' }
ToSelectionModelSelecter >> addWholeSelectionCommand: aCommand [

	self currentIndex: 0
]

{ #category : #'command application' }
ToSelectionModelSelecter >> apply [

	self applyOn: self target
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #initialization }
ToSelectionModelSelecter >> initialize [ 

	super initialize.
	currentIndex := 0
]

{ #category : #accessing }
ToSelectionModelSelecter >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #private }
ToSelectionModelSelecter >> nextIdxTowardEnd [ 

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
ToSelectionModelSelecter >> nextIdxTowardStart [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ 0 ].
			^ self itemCount ]
		ifFalse: [ self currentIndex > 1 ifFalse: [ ^ self itemCount ] ].
	^ self currentIndex - 1
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onInstalledIn: anEventTarget [

	self target: anEventTarget
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onUninstalledIn: anEventTarget [

	self target: nil.

	

]

{ #category : #'applied command handling' }
ToSelectionModelSelecter >> removeIndexesSelectionCommand: aCommand [

	self currentIndex: aCommand indexes first
]

{ #category : #'applied command handling' }
ToSelectionModelSelecter >> removeIntervalSelectionCommand: aCommand [

	self currentIndex: aCommand to
]

{ #category : #'applied command handling' }
ToSelectionModelSelecter >> removeWholeSelectionCommand: aCommand [

	self currentIndex: 0
]

{ #category : #operations }
ToSelectionModelSelecter >> selectAndScrollToIndex: anIndex [

	self selectIndex: anIndex.
	self addCommand: (ToSelectionHolderCommand new
			 action: [ :e |
				 e selectionModel ifNotEmpty: [ e scrollToIndex: anIndex ] ];
			 yourself)
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectAndScrollToNext [

	| nextIdx |
	nextIdx := self nextIdxTowardEnd.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectAndScrollToNextDeselected [

	self selectAndScrollToIndex: (self sideIdx: 1)
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectAndScrollToPrevious [

	| nextIdx |
	nextIdx := self nextIdxTowardStart.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectAndScrollToPreviousDeselected [

	self selectAndScrollToIndex: (self sideIdx: -1)
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self selectIndex: curr to: index
]

{ #category : #accessing }
ToSelectionModelSelecter >> selectionModel [

	^ self target selectionModel
]

{ #category : #private }
ToSelectionModelSelecter >> sideIdx: aGap [

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
ToSelectionModelSelecter >> target [

	^ target
]

{ #category : #accessing }
ToSelectionModelSelecter >> target: anEventTarget [

	target := anEventTarget
]
