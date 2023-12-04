Class {
	#name : 'ToInstallStateTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-States',
	#package : 'Toplo-Tests',
	#tag : 'Core-States'
}

{ #category : 'running' }
ToInstallStateTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'running' }
ToInstallStateTest >> testApplyOn [ 

	| e stateEvt receivedEvt |
	e := ToElement new.
	e when: ToInstallLookEvent do: [ :event | receivedEvt := event ].
	(stateEvt := ToInstallState new) applyOn: e.
	self assert: (receivedEvt isKindOf: ToInstallLookEvent)
	
]

{ #category : 'running' }
ToInstallStateTest >> testCanBeEnqueuedFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToInstallState new.
	" An element is not allowed to enqueue a management state"
	self should: [state canBeEnqueuedFromElement: e inQueue: e skinStateQueue] raise: Error
]

{ #category : 'running' }
ToInstallStateTest >> testLookEvent [

	| state  |
	state := ToInstallState new.
	self assert: (state lookEvent isKindOf: ToInstallLookEvent) 
	
]

{ #category : 'running' }
ToInstallStateTest >> testRequestEnqueueFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToInstallState new.
	self should: [state requestEnqueueFromElement: e inQueue: e skinStateQueue ] raise: Error
]
