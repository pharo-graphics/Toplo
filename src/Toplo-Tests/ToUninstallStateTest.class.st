Class {
	#name : 'ToUninstallStateTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-States',
	#package : 'Toplo-Tests',
	#tag : 'Core-States'
}

{ #category : 'running' }
ToUninstallStateTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'tests' }
ToUninstallStateTest >> testApplyOn [ 

	| e stateEvt receivedEvt |
	e := ToElement new.
	e when: ToUninstallLookEvent do: [ :event | receivedEvt := event ].
	(stateEvt := ToUninstallState new) applyOn: e.
	self assert: (receivedEvt isKindOf: ToUninstallLookEvent)
	
]

{ #category : 'tests' }
ToUninstallStateTest >> testCanBeEnqueuedFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToUninstallState new.
	" An element is not allowed to enqueue a management state"
	self should: [state canBeEnqueuedFromElement: e inQueue: e skinStateQueue] raise: Error
]

{ #category : 'tests' }
ToUninstallStateTest >> testLookEvent [

	| state  |
	state := ToUninstallState new.
	self assert: (state lookEvent isKindOf: ToUninstallLookEvent) 
	
]

{ #category : 'tests' }
ToUninstallStateTest >> testRequestEnqueueFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToUninstallState new.
	self should: [state requestEnqueueFromElement: e inQueue: e skinStateQueue ] raise: Error
]
