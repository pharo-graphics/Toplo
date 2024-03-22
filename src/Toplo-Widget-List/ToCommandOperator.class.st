Class {
	#name : #ToCommandOperator,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher',
		'sharedEventDistributor'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #accessing }
ToCommandOperator >> addCommand: aCommand [

	self dispatchEvent: (ToElementCommandAddedEvent new
			 command: aCommand
			 yourself)
]

{ #category : #'command application' }
ToCommandOperator >> applyCommand: aCommand in: aTarget [ 
	
	aCommand applyOn: aCommand operator in: aTarget
]

{ #category : #'event management accessing' }
ToCommandOperator >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #initialization }
ToCommandOperator >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #'api - hooks' }
ToCommandOperator >> onInstalledIn: anEventTarget [

	sharedEventDistributor ifNotNil: [ Error signal: 'A CommandTarget can be installed only once' ].
	sharedEventDistributor := BlSharedEventDistributor new
		                          shareEvents: self sharedEvents;
		                          yourself.
	self addEventHandler: sharedEventDistributor.
	anEventTarget addEventHandler: sharedEventDistributor
]

{ #category : #'api - hooks' }
ToCommandOperator >> onUninstalledIn: anEventTarget [

	sharedEventDistributor ifNil: [ Error signal: 'Not installed' ].
	self removeEventHandler: sharedEventDistributor.
	anEventTarget removeEventHandler: sharedEventDistributor.
	sharedEventDistributor := nil
]

{ #category : #accessing }
ToCommandOperator >> sharedEvents [ 

	^ { ToElementCommandAddedEvent }
]
