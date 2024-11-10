Class {
	#name : #ToExShapeContainerManager,
	#superclass : #Object,
	#instVars : [
		'commandApplicationStrategy',
		'shapeContainer',
		'processes'
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

	^ ToExShapeCommandApplicationStrategy new
]

{ #category : #initialization }
ToExShapeContainerManager >> initialize [ 

	super initialize.
	processes := OrderedCollection new
]

{ #category : #'instance creation' }
ToExShapeContainerManager >> open [

	self shapeContainer: ToExShapeContainerElement new.
	shapeContainer openInSpace.
	shapeContainer
		addEventHandlerOn: BlElementRemovedFromSceneGraphEvent
		do: [ self terminateAllProcesses ].
	self addCommand: (ToExShapeNewGenerationCommand new
			 size: 2000;
			 yourself).
	self startShuffleProcess.
	self startSortProcess.
	self startRemoveProcess
]

{ #category : #'private - processes' }
ToExShapeContainerManager >> processPriority [

	^ Processor userBackgroundPriority
]

{ #category : #'private - processes' }
ToExShapeContainerManager >> registerProcess: aProcess [

	processes add: aProcess
]

{ #category : #accessing }
ToExShapeContainerManager >> shapeContainer: aShapeContainer [

	shapeContainer := aShapeContainer.
	commandApplicationStrategy := self defaultCommandApplicationStrategy.
	commandApplicationStrategy commandApplier: self element: shapeContainer
]

{ #category : #'private - processes' }
ToExShapeContainerManager >> startProcess: aProcess [

	aProcess
		priority: self processPriority;
		name: self class name , ' process'.
	self registerProcess: aProcess.
	aProcess resume
]

{ #category : #'private - processes' }
ToExShapeContainerManager >> startRemoveProcess [

	| rand process |
	rand := Random new.
	process := [
	           [ shapeContainer shapes isEmpty ] whileTrue: [
		           Delay forMilliseconds: 300 ].
	           'Remove process started' traceCr.
	           [ shapeContainer shapes size < 2 ] whileFalse: [
		           | indexes |
		           indexes := Array streamContents: [ :stream |
			                      1 to: 4 do: [ :n |
				                      stream nextPut:
					                      (rand
						                       nextBetween: 1
						                       and: shapeContainer shapes size)
						                      asInteger ] ].
		           self addCommand: (ToExShapeRemoveCommand new
				            indexes: indexes;
				            yourself).
		           (Delay forMilliseconds: 50) wait ].
	           'Remove process finished' traceCr] newProcess.
	self startProcess: process
]

{ #category : #'private - processes' }
ToExShapeContainerManager >> startShuffleProcess [

	| process |
	process := [
	           | round |
	           round := 0.
	           'Shuffle process started' traceCr.
	           [ round < 100 and: [ shapeContainer shapes size > 2 ] ]
		           whileTrue: [
			           round := round + 1.
			           self addCommand: ToExShapeShuffleCommand new.
			           (Delay forMilliseconds: 300) wait ].
	           'Shuffle process finished' traceCr] newProcess.
	self startProcess: process
]

{ #category : #'private - processes' }
ToExShapeContainerManager >> startSortProcess [

	| process |
	process := [
	           | round |
	           round := 0.
	           'Sort process started' traceCr.
	           [ round < 200 and: [ shapeContainer shapes size > 2 ] ]
		           whileTrue: [
			           round := round + 1.
			           round odd
				           ifTrue: [
				           commandApplicationStrategy sortBlock: [ :a :b |
					           b num < a num ] ]
				           ifFalse: [
				           commandApplicationStrategy sortBlock: [ :a :b |
					           a num < b num ] ].
			           (Delay forMilliseconds: 100) wait ].
	           commandApplicationStrategy sortBlock: nil.
	           'Sort process finished' traceCr ] newProcess.
	self startProcess: process
]

{ #category : #'private - processes' }
ToExShapeContainerManager >> terminateAllProcesses [

	processes do: [ :p | p terminate ].
	processes removeAll
]
