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
ToQueueBasedCommandApplicationStrategy >> addCommand: aCommand [ 

	weak ifTrue: [
		element isAttachedToSceneGraph ifFalse: [
			commandApplier applyCommand: aCommand.
			^ self ] ].

	commandQueue add: aCommand.
	self postApplicationTask
]

{ #category : #accessing }
ToQueueBasedCommandApplicationStrategy >> commandApplier: aCommandApplier element: anElement [

	super commandApplier: aCommandApplier element: anElement.
	commandQueue := OrderedCollection new.
	applicationTask := self newCommandApplicationTask
		                   element: anElement;
		                   applier: aCommandApplier;
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
