Class {
	#name : #ToExShapeContainerManager,
	#superclass : #Object,
	#instVars : [
		'commandApplicationStrategy',
		'shapeContainer'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #'instance creation' }
ToExShapeContainerManager class >> open [ 

	<script>
	self new open
]

{ #category : #adding }
ToExShapeContainerManager >> addCommand: aCommand [

	commandApplicationStrategy addCommand: aCommand 
]

{ #category : #adding }
ToExShapeContainerManager >> applyCommand: aCommand [

	aCommand applyOn: shapeContainer 
]

{ #category : #initialization }
ToExShapeContainerManager >> defaultCommandApplicationStrategy [

	^ ToQueueBasedCommandApplicationStrategy new
]

{ #category : #'instance creation' }
ToExShapeContainerManager >> open [

	self shapeContainer: ToExShapeContainerElement new.
	shapeContainer openInSpace.
	self addCommand: (ToExShapeNewGenerationCommand new
			 size: 1000;
			 yourself).
	self startShuffleProcess.
	self startSortProcess
]

{ #category : #accessing }
ToExShapeContainerManager >> shapeContainer: aShapeContainer [

	shapeContainer := aShapeContainer.
	commandApplicationStrategy := self defaultCommandApplicationStrategy.
	commandApplicationStrategy commandApplier: self element: shapeContainer
]

{ #category : #'instance creation' }
ToExShapeContainerManager >> startShuffleProcess [

	[
	self inform: 'Shuffle process started'.
	1 to: 150 do: [ :n |
		self addCommand: ToExShapeShuffleCommand new.
		(Delay forMilliseconds: 300) wait ].
	self inform: 'Shuffle process finished' ] fork
]

{ #category : #'instance creation' }
ToExShapeContainerManager >> startSortProcess [

	[
	self inform: 'Sort process started'.
	1 to: 500 do: [ :n |
		n odd
			ifTrue: [
				self addCommand: (ToExShapeSortCommand new
						 sortBlock: [ :a :b | b num < a num ];
						 yourself) ]
			ifFalse: [
				self addCommand: (ToExShapeSortCommand new
						 sortBlock: [ :a :b | a num < b num ];
						 yourself) ].

		(Delay forMilliseconds: 50) wait ].
	self inform: 'Sort process finished' ] fork
]
