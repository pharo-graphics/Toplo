"
A TToLinkableTest is a test class for testing the behavior of TToLinkable
"
Class {
	#name : #TToLinkableTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
TToLinkableTest >> setUp [

	super setUp.
	element := ToElement new size: 50 asPoint.
	space root addChild: element.
]

{ #category : #tests }
TToLinkableTest >> testClickAction [

	| received |
	received := nil.
	element clickAction: [ :evt | received := evt ].
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: received notNil
	
]

{ #category : #tests }
TToLinkableTest >> testLinkClickAction [

	| received prevReceived runCount |
	received := nil.
	runCount := 0.
	self assert: element linkedActions isEmpty.
	element linkClickAction: [ :evt |
			received := evt.
			runCount := runCount + 1 ].
	self assert: element linkedActions size equals: 1.
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: received notNil.
	self assert: runCount equals: 1.
	prevReceived := received.
	received := nil.
	element linkedActions do: [ :action | action run ].
	self assert: received isNil.
	self assert: runCount equals: 2.
	received := nil.
	element linkedActions do: [ :action |
		action runWithEvent: prevReceived ].
	self assert: received equals: prevReceived.
	self assert: runCount equals: 3
]

{ #category : #tests }
TToLinkableTest >> testNewClickAction [

	| received prevReceived action passedInAction |
	received := nil.
	passedInAction := false.
	action := element newClickAction: [ :evt |
			          received := evt.
			          passedInAction := true ].
	self assert: action notNil.
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: received notNil.
	self assert: passedInAction.
	prevReceived := received.
	received := nil.
	passedInAction := false.
	action run.
	self assert: received isNil.
	self assert: passedInAction.
	received := nil.
	passedInAction := false.
	action runWithEvent: prevReceived.
	self assert: received equals: prevReceived.
	self assert: passedInAction
]

{ #category : #tests }
TToLinkableTest >> testUnlinkAllActions [

	| runCount blk |
	self assert: element linkedActions isEmpty.
	runCount := 0.
	blk := [ :evt |
			runCount := runCount + 1 ].
	element linkClickAction: blk.
	element linkClickAction: blk.
	
	" 2 new click actions "
	self assert: element linkedActions size equals: 2.
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: runCount equals: 2.
	
	element linkedActions do: [ :action | action run ].
	" run actions programmatically "
	self assert: runCount equals: 4.
	
	element unlinkAllActions.	
	" no more action to run on click "
	self assert: element linkedActions size equals: 0.
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: runCount equals: 4.



]
