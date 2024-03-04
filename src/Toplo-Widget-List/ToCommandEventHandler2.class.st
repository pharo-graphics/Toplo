Class {
	#name : #ToCommandEventHandler2,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'applicationTask',
		'commandQueue'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'event handling' }
ToCommandEventHandler2 >> addComand: aCommand fromOperator: anOperator forTarget: aTarget [

	| targetedCommand |

	targetedCommand := ToApplicableCommand new
		                   operator: anOperator;
		                   target: aTarget;
		                   command: aCommand;
		                   yourself.

	aTarget dataSourceManager onOtherCommand: targetedCommand.
	"aTarget infinite postChildrenUpdater."
]

{ #category : #'event handling' }
ToCommandEventHandler2 >> applyAllCommands [

	| nextInQueue |
	[ (nextInQueue := commandQueue nextOrNil) isNotNil ] whileTrue: [
		nextInQueue apply ]
]

{ #category : #'event handling' }
ToCommandEventHandler2 >> commandAddedEvent: aCommandAddedEvent [

	self
		addComand: aCommandAddedEvent command
		fromOperator: aCommandAddedEvent operator
		forTarget: aCommandAddedEvent currentTarget
]

{ #category : #'event handling' }
ToCommandEventHandler2 >> commandApplicationRequestEvent: aCommandApplicationRequestEvent [

	applicationTask ifNotNil: [
		aCommandApplicationRequestEvent currentTarget dequeueTask: applicationTask.
		applicationTask := nil ].
	self applyAllCommands
]

{ #category : #'api - accessing' }
ToCommandEventHandler2 >> eventsToHandle [

	^ { ToCommandAddedEvent. ToCommandApplicationRequestEvent }
]

{ #category : #initialization }
ToCommandEventHandler2 >> initialize [ 

	super initialize.
	commandQueue := WaitfreeQueue new.
]
