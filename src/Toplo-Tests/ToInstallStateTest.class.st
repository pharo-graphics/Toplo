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
	(stateEvt := ToInstallState instance) applyOn: e fromQueue: nil.
	self assert: (receivedEvt isKindOf: ToInstallSkinEvent)
]

{ #category : #running }
ToInstallStateTest >> testSkinEvent [

	| state  |
	state := ToInstallState instance.
	self assert: (state skinEvent isKindOf: ToInstallSkinEvent) 
	
]
