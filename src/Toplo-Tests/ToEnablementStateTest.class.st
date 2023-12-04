Class {
	#name : 'ToEnablementStateTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-States',
	#package : 'Toplo-Tests',
	#tag : 'Core-States'
}

{ #category : 'running' }
ToEnablementStateTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'running' }
ToEnablementStateTest >> testApplyOn [ 

	| e  receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	space root addChild: e.
	e when: ToEnabledLookEvent do: [ :event | receivedEnabledEvt := event ].
	e when: ToDisabledLookEvent do: [ :event | receivedDisabledEvt := event ].
	e when: ToElementLookEvent do: [ :event | event traceCr ].
	e applySkinInstaller.
	self assert: (receivedEnabledEvt isKindOf: ToEnabledLookEvent)
	
]

{ #category : 'running' }
ToEnablementStateTest >> testApplyOn2 [

	| e  receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e enable.
	space root addChild: e.
	e when: ToEnabledLookEvent do: [ :event | receivedEnabledEvt := event ].
	e when: ToDisabledLookEvent do: [ :event | receivedDisabledEvt := event ].
	e when: ToElementLookEvent do: [ :event | event traceCr ].
	e applySkinInstaller.
	self assert: (receivedEnabledEvt isKindOf: ToEnabledLookEvent)
	
]

{ #category : 'running' }
ToEnablementStateTest >> testApplyOn3 [

	| e  receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	space root addChild: e.
	e enable.
	e when: ToEnabledLookEvent do: [ :event | receivedEnabledEvt := event ].
	e when: ToDisabledLookEvent do: [ :event | receivedDisabledEvt := event ].
	e when: ToElementLookEvent do: [ :event | event traceCr ].
	e applySkinInstaller.
	self assert: (receivedEnabledEvt isKindOf: ToEnabledLookEvent)
	
]

{ #category : 'running' }
ToEnablementStateTest >> testApplyOnWhenDisabled [

	| e  receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e disable.
	space root addChild: e.
	e when: ToEnabledLookEvent do: [ :event | receivedEnabledEvt := event ].
	e when: ToDisabledLookEvent do: [ :event | receivedDisabledEvt := event ].
	e when: ToElementLookEvent do: [ :event | event traceCr ].
	e applySkinInstaller.
	self assert: (receivedDisabledEvt isKindOf: ToDisabledLookEvent)
	
]

{ #category : 'running' }
ToEnablementStateTest >> testApplyOnWhenDisabled2 [

	| e  receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	space root addChild: e.
	e disable.
	e when: ToEnabledLookEvent do: [ :event | receivedEnabledEvt := event ].
	e when: ToDisabledLookEvent do: [ :event | receivedDisabledEvt := event ].
	e when: ToElementLookEvent do: [ :event | event traceCr ].
	e applySkinInstaller.
	self assert: (receivedDisabledEvt isKindOf: ToDisabledLookEvent)
	
]

{ #category : 'tests' }
ToEnablementStateTest >> testCanBeEnqueuedFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToEnablementState new enabled: true.
	" An element is not allowed to enqueue a management state"
	self should: [state canBeEnqueuedFromElement: e inQueue: e skinStateQueue] raise: Error
]

{ #category : 'running' }
ToEnablementStateTest >> testLookEvent [

	| state  |
	state := ToEnablementState new enabled: true.
	self assert: (state lookEvent isKindOf: ToEnabledLookEvent).
	state := ToEnablementState new enabled: false.
	self assert: (state lookEvent isKindOf: ToDisabledLookEvent) 

	
]

{ #category : 'tests' }
ToEnablementStateTest >> testRequestEnqueueFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToEnablementState new enabled: true.
	self should: [state requestEnqueueFromElement: e inQueue: e skinStateQueue ] raise: Error
]
