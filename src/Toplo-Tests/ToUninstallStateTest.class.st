Class {
	#name : #ToUninstallStateTest,
	#superclass : #ToTestCaseWithSpace,
	#category : 'Toplo-Tests-Core-States'
}

{ #category : #running }
ToUninstallStateTest >> testApplyOn [

	| e stateEvt receivedEvt |
	e := ToElement new.
	e addEventHandler: (BlEventHandler
			 on: ToUninstallLookEvent
			 do: [ :event | receivedEvt := event ]).
	(stateEvt := ToUninstallState new) applyOn: e.
	self assert: (receivedEvt isKindOf: ToUninstallLookEvent)
]

{ #category : #running }
ToUninstallStateTest >> testCanBeEnqueuedFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToUninstallState new.
	" An element is not allowed to enqueue a management state"
	self should: [state canBeEnqueuedFromElement: e inQueue: e skinStateQueue] raise: Error
]

{ #category : #running }
ToUninstallStateTest >> testLookEvent [

	| state  |
	state := ToUninstallState new.
	self assert: (state lookEvent isKindOf: ToUninstallLookEvent) 
	
]

{ #category : #running }
ToUninstallStateTest >> testRequestEnqueueFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToUninstallState new.
	self should: [state requestEnqueueFromElement: e inQueue: e skinStateQueue ] raise: Error
]
