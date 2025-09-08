"
A ToActionLinkSetTest is a test class for testing the behavior of ToActionLinkSet
"
Class {
	#name : #ToActionLinkPoolTest,
	#superclass : #TestCase,
	#instVars : [
		'actionPool'
	],
	#category : #'Toplo-Tests-Core-WidgetLink'
}

{ #category : #running }
ToActionLinkPoolTest >> setUp [

	super setUp.
	actionPool := ToActionPool new
]

{ #category : #tests }
ToActionLinkPoolTest >> testAllActionsAreRunned [

	| actionLink count |
	self testRegisterActionLink.
	count := 0.
	actionLink := actionPool actionLinks anyOne.
	actionLink action: [ count := count + 1 ].
	actionLink requestNextRun.
	self assert: count equals: 1.
	self assert: actionPool allActionsAreRunned
]

{ #category : #tests }
ToActionLinkPoolTest >> testAllActionsAreRunned2 [

	| actionLink1 actionLink2 links |
	self testRegisterActionLink.
	self testRegisterActionLink.
	links := actionPool actionLinks asArray.
	actionLink1 := links first.
	actionLink2 := links second.
	actionLink1 requestNextRun.
	self assert: actionPool runCount equals: 0.
	self deny: actionPool allActionsAreRunned.
	actionLink2 requestNextRun.
	self assert: actionPool runCount equals: 1.
	self assert: actionPool allActionsAreRunned
]

{ #category : #tests }
ToActionLinkPoolTest >> testAllActionsAreRunned3 [

	| actionLink setRunCount runCount |
	self testAllActionsAreRunned2.
	setRunCount := actionPool runCount.
	actionLink := actionPool actionLinks anyOne.
	runCount := actionLink runCount.
	actionPool unregisterActionLink: actionLink.
	actionLink requestNextRun.
	" The runCount is reset when unregistering (this why the 0) and 
	no new run regarding actions because the action link has been unregistered "
	self assert: actionPool runCount equals: 1.
	setRunCount := actionPool runCount.

	self assert: actionPool allActionsAreRunned.
	" but the unregistered actionLink has well been runned "
	self assert: actionLink runCount equals: runCount + 1.
	
	" get a registered actionLink "
	actionLink := actionPool actionLinks anyOne.
	actionLink requestNextRun.
	" one new run regarding actions because the actions contains only one actionLink  "
	self assert: actionPool runCount equals: setRunCount + 1.
	self assert: actionPool allActionsAreRunned
]

{ #category : #tests }
ToActionLinkPoolTest >> testNewActionLinkSet [

	self assert: (actionPool registeredActionLinks isKindOf: Set).
	self assert: (actionPool actionLinks isKindOf: Set).
	self assert: actionPool registeredActionLinks isEmpty.
	self assert: actionPool holder isNil
]

{ #category : #tests }
ToActionLinkPoolTest >> testRegisterActionLink [

	| actionLink s found beforeHandlerNb afterHandlerNb |
	actionLink := ToActionLink new.
	s := actionPool registeredActionLinks size.
	beforeHandlerNb := 0.
	actionLink eventDispatcher handlersDo: [ :h |
			h eventClass = ToActionRunnedEvent ifTrue: [
				beforeHandlerNb := beforeHandlerNb + 1 ] ].
	actionPool registerActionLink: actionLink.
	self assert: actionPool registeredActionLinks size equals: s + 1.
	found := actionPool registeredActionLinks
		         detect: [ :ral | ral actionLink = actionLink ]
		         ifNone: [ ].
	self assert: (found isKindOf: ToRegisteredActionLink).
	self assert: found actionLink equals: actionLink.
	afterHandlerNb := 0.
	actionLink eventDispatcher handlersDo: [ :h |
			h eventClass = ToActionRunnedEvent ifTrue: [
				afterHandlerNb := afterHandlerNb + 1 ] ].
	self assert: afterHandlerNb equals: beforeHandlerNb + 1
]

{ #category : #tests }
ToActionLinkPoolTest >> testRegisterAndRunInRunnedAction [

	| actionLink |
	actionLink := ToActionLink new.
	actionPool registerActionLink: actionLink.
	actionLink action: [
			| newActionLink |
			newActionLink := ToActionLink new.
			actionPool registerActionLink: newActionLink.
			newActionLink requestNextRun ].
	actionLink requestNextRun.
	self assert: actionPool allActionsAreRunned
]

{ #category : #tests }
ToActionLinkPoolTest >> testRegisterInRunnedAction [

	| actionLink |
	actionLink := ToActionLink new.
	actionPool registerActionLink: actionLink.
	actionLink action: [
			| newActionLink |
			newActionLink := ToActionLink new.
			actionPool registerActionLink: newActionLink ].
	actionLink requestNextRun.
	self assert: actionPool allActionsAreRunned
]

{ #category : #tests }
ToActionLinkPoolTest >> testUnregisterActionLink [

	| actionLink s found beforeHandlerNb afterHandlerNb |
	actionLink := ToActionLink new.
	s := actionPool registeredActionLinks size.
	beforeHandlerNb := 0.
	actionLink eventDispatcher handlersDo: [ :h |
			h eventClass = ToActionRunnedEvent ifTrue: [
				beforeHandlerNb := beforeHandlerNb + 1 ] ].
	actionPool registerActionLink: actionLink.
	actionPool unregisterActionLink: actionLink.
	self assert: actionPool registeredActionLinks size equals: s.
	found := actionPool registeredActionLinks
		         detect: [ :ral | ral actionLink = actionLink ]
		         ifNone: [ ].
	self assert: found isNil.
	afterHandlerNb := 0.
	actionLink eventDispatcher handlersDo: [ :h |
			h eventClass = ToActionRunnedEvent ifTrue: [
				afterHandlerNb := afterHandlerNb + 1 ] ].
	self assert: afterHandlerNb equals: beforeHandlerNb
]

{ #category : #tests }
ToActionLinkPoolTest >> testUnregisterInRunnedAction [

	| actionLink1 actionLink2 |
	actionLink1 := ToActionLink new.
	actionPool registerActionLink: actionLink1.
	actionLink2 := ToActionLink new.
	actionPool registerActionLink: actionLink2.
	
	actionLink1 requestNextRun.
	self deny: actionPool allActionsAreRunned.
	actionLink2 requestNextRun.
	self assert: actionPool allActionsAreRunned.
		
	actionLink1 action: [ actionPool unregisterActionLink: actionLink1 ].
	self assert: actionPool allActionsAreRunned.


]
