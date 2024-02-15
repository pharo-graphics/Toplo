Class {
	#name : #ToSelectionModelOperator,
	#superclass : #ToCommandOperator,
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

	self selectionModel selectIndex: aCommand from to: aCommand to.
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

{ #category : #'api - hooks' }
ToSelectionModelOperator >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	self selectionModel: anEventTarget selectionModel
]

{ #category : #'api - hooks' }
ToSelectionModelOperator >> onUninstalledIn: anEventTarget [

	super onUninstalledIn: anEventTarget.
	self selectionModel: nil
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
