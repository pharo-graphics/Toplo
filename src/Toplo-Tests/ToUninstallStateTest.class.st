Class {
	#name : #ToUninstallStateTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #running }
ToUninstallStateTest >> testApplyOn [

	| e stateEvt receivedEvt |
	e := ToElement new.
	e addEventHandler: (BlEventHandler
			 on: ToUninstallSkinEvent
			 do: [ :event | receivedEvt := event ]).
	(stateEvt := ToUninstallState new) applyOn: e fromQueue: nil.
	self assert: (receivedEvt isKindOf: ToUninstallSkinEvent)
]

{ #category : #running }
ToUninstallStateTest >> testCanBeEnqueuedFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToUninstallState new.
	" An element is not allowed to enqueue a management state"
	self
		should: [
			state
				canBeEnqueuedFromElement: e
				inQueue: e skinManager skinStateQueue ]
		raise: Error
]

{ #category : #running }
ToUninstallStateTest >> testRequestEnqueueFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToUninstallState new.
	self
		should: [
			state
				requestEnqueueFromElement: e
				inQueue: e skinManager skinStateQueue ]
		raise: Error
]

{ #category : #running }
ToUninstallStateTest >> testSkinEvent [

	| state  |
	state := ToUninstallState new.
	self assert: (state skinEvent isKindOf: ToUninstallSkinEvent) 
	
]
