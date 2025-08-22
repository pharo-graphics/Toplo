Class {
	#name : #ToEnablementStateTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #running }
ToEnablementStateTest >> testApplyOn [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e applySkinInstallerOnFirstRequest: false.
	space root addChild: e.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	e skinManager applySkinReinstallIn: e.
	self assert: (receivedEnabledEvt isKindOf: ToEnabledSkinEvent)
]

{ #category : #running }
ToEnablementStateTest >> testApplyOn2 [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e applySkinInstallerOnFirstRequest: false.
	e enable.
	space root addChild: e.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	e skinManager applySkinReinstallIn: e.
	self assert: (receivedEnabledEvt isKindOf: ToEnabledSkinEvent)
]

{ #category : #running }
ToEnablementStateTest >> testApplyOn3 [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e applySkinInstallerOnFirstRequest: false.

	space root addChild: e.
	e enable.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	e skinManager applySkinReinstallIn: e.
	self assert: (receivedEnabledEvt isKindOf: ToEnabledSkinEvent)
]

{ #category : #running }
ToEnablementStateTest >> testApplyOnWhenDisabled [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e applySkinInstallerOnFirstRequest: false.
	e disable.
	space root addChild: e.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	e skinManager applySkinReinstallIn: e.
	self assert: (receivedDisabledEvt isKindOf: ToDisabledSkinEvent)
]

{ #category : #running }
ToEnablementStateTest >> testApplyOnWhenDisabled2 [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e applySkinInstallerOnFirstRequest: false.
	space root addChild: e.
	e disable.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	e skinManager applySkinReinstallIn: e.
	self assert: (receivedDisabledEvt isKindOf: ToDisabledSkinEvent)
]

{ #category : #tests }
ToEnablementStateTest >> testCanBeEnqueuedFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToEnablementState new enabled: true.
	" An element is not allowed to enqueue a management state"
	self
		should: [
			state
				canBeEnqueuedFromElement: e
				inQueue: e skinManager skinStateQueue ]
		raise: Error
]

{ #category : #tests }
ToEnablementStateTest >> testRequestEnqueueFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToEnablementState new enabled: true.
	self
		should: [
			state
				requestEnqueueFromElement: e
				inQueue: e skinManager skinStateQueue ]
		raise: Error
]

{ #category : #running }
ToEnablementStateTest >> testSkinEvent [

	| state  |
	state := ToEnablementState new enabled: true.
	self assert: (state skinEvent isKindOf: ToEnabledSkinEvent).
	state := ToEnablementState new enabled: false.
	self assert: (state skinEvent isKindOf: ToDisabledSkinEvent) 

	
]
