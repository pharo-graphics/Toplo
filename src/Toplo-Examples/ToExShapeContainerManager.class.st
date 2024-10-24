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
	[
	1 to: 500 do: [ :n |
		self addCommand: ToExShapeShuffleCommand new.
		n odd
			ifTrue: [
				self addCommand: (ToExShapeSortCommand new
						 sortBlock: [ :a :b | b num < a num ];
						 yourself) ]
			ifFalse: [
				self addCommand: (ToExShapeSortCommand new
						 sortBlock: [ :a :b | a num < b num ];
						 yourself) ].

		(Delay forMilliseconds: 50) wait ] ] fork
]

{ #category : #accessing }
ToExShapeContainerManager >> shapeContainer: aShapeContainer [

	shapeContainer := aShapeContainer.
	commandApplicationStrategy := self defaultCommandApplicationStrategy.
	commandApplicationStrategy commandApplier: self element: shapeContainer
]
