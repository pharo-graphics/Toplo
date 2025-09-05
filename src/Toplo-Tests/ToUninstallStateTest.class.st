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
	(stateEvt := ToUninstallState instance) applyOn: e fromQueue: nil.
	self assert: (receivedEvt isKindOf: ToUninstallSkinEvent)
]

{ #category : #running }
ToUninstallStateTest >> testSkinEvent [

	| state  |
	state := ToUninstallState instance.
	self assert: (state skinEvent isKindOf: ToUninstallSkinEvent) 
	
]
