Class {
	#name : #ToQueueBasedCommandApplicationStrategy,
	#superclass : #ToCommandApplicationStrategy,
	#instVars : [
		'commandQueue',
		'applicationTask',
		'queued',
		'weak'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToQueueBasedCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	weak ifTrue: [
		element isAttachedToSceneGraph ifFalse: [
			aCommandApplier applyCommand: aCommand.
			^ self ] ].

	commandQueue add: (ToEnqueuedCommand new
			 command: aCommand;
			 applier: aCommandApplier;
			 yourself).
	self postApplicationTask.
	super addCommand: aCommand from: aCommandApplier
]

{ #category : #accessing }
ToQueueBasedCommandApplicationStrategy >> element: anElement [

	super element: anElement.
	commandQueue := OrderedCollection new.
	applicationTask := self newCommandApplicationTask
		                   element: anElement;
		                   commandQueue: commandQueue;
		                   finishedAction: [ queued := false ];
		                   yourself.
	queued := false
]

{ #category : #initialization }
ToQueueBasedCommandApplicationStrategy >> initialize [ 

	super initialize.
	weak := true
]

{ #category : #accessing }
ToQueueBasedCommandApplicationStrategy >> newCommandApplicationTask [ 

	^ ToCommandApplicationTask new
]

{ #category : #'event handling' }
ToQueueBasedCommandApplicationStrategy >> postApplicationTask [
	"Post children update runnable to consume update operations"
	queued ifTrue: [ ^ self ].
	queued := true.
	" Allow re-lauching of the same task"
	applicationTask setNew.
	" enqueue the update task "
	element enqueueTask: applicationTask
]

{ #category : #accessing }
ToQueueBasedCommandApplicationStrategy >> weak: aBoolean [

	weak := aBoolean
]
