Class {
	#name : #ToInstallStateTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #running }
ToInstallStateTest >> testApplyOn [

	| e stateEvt receivedEvt |
	e := ToElement new.
	e addEventHandler: (BlEventHandler
			 on: ToInstallSkinEvent
			 do: [ :event | receivedEvt := event ]).
	(stateEvt := ToInstallState new) applyOn: e fromQueue: nil.
	self assert: (receivedEvt isKindOf: ToInstallSkinEvent)
]

{ #category : #running }
ToInstallStateTest >> testCanBeEnqueuedFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToInstallState new.
	" An element is not allowed to enqueue a management state"
	self
		should: [
			state
				canBeEnqueuedFromElement: e
				inQueue: e skinManager skinStateQueue ]
		raise: Error
]

{ #category : #running }
ToInstallStateTest >> testRequestEnqueueFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToInstallState new.
	self
		should: [
			state
				requestEnqueueFromElement: e
				inQueue: e skinManager skinStateQueue ]
		raise: Error
]

{ #category : #running }
ToInstallStateTest >> testSkinEvent [

	| state  |
	state := ToInstallState new.
	self assert: (state skinEvent isKindOf: ToInstallSkinEvent) 
	
]
