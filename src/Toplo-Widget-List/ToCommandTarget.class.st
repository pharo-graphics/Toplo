Class {
	#name : #ToCommandTarget,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToCommandOperator',
	#classTraits : 'TBlEventTarget classTrait + TToCommandOperator classTrait',
	#instVars : [
		'eventDispatcher',
		'sharedEventDistributor'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'event management accessing' }
ToCommandTarget >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #initialization }
ToCommandTarget >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #'api - hooks' }
ToCommandTarget >> onInstalledIn: anEventTarget [

	sharedEventDistributor ifNotNil: [ Error signal: 'A CommandTarget can be installed only once' ].
	sharedEventDistributor := BlSharedEventDistributor new
		                          shareEvents: self sharedEvents;
		                          yourself.
	self addEventHandler: sharedEventDistributor.
	anEventTarget addEventHandler: sharedEventDistributor
]

{ #category : #'api - hooks' }
ToCommandTarget >> onUninstalledIn: anEventTarget [

	sharedEventDistributor ifNil: [ Error signal: 'Not installed' ].
	self removeEventHandler: sharedEventDistributor.
	anEventTarget removeEventHandler: sharedEventDistributor.
	sharedEventDistributor := nil
]

{ #category : #accessing }
ToCommandTarget >> sharedEvents [ 

	^ { ToCommandAddedEvent }
]
