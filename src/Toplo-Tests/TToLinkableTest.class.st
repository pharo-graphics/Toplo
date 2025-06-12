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
TToLinkableTest >> testAddLinkedAction [

	| action |
	action := element newClickAction: [ :evt |  ].
	self assert: element linkedActions size equals: 0.
	element addLinkedAction: action.
	self assert: element linkedActions size equals: 1.
	element addLinkedAction: action.
	self assert: element linkedActions size equals: 1.


	
]

{ #category : #tests }
TToLinkableTest >> testCheckAction [

	| received checkable |
	received := nil.
	checkable := ToCheckbox new labelText: 'XXXXX'; yourself.
	space root addChild: checkable.
	checkable checkAction: [ :evt | received := evt ].
	checkable dispatchEvent: (ToCheckableChangedEvent new
			 checked: true;
			 yourself).
	self assert: (received isKindOf: ToCheckableChangedEvent).
	received := nil.
	BlSpace simulateClickOn: checkable.
	self assert: (received isKindOf: ToCheckableChangedEvent).

]

{ #category : #tests }
TToLinkableTest >> testCheckActionWith [

	| received checkable theElement value |
	received := nil.
	theElement := nil.
	value := nil.
	checkable := ToCheckbox new
		             labelText: 'XXXXX';
		             yourself.
	space root addChild: checkable.
	checkable
		checkAction: [ :evt :obj :val |
				received := evt.
				theElement := obj.
				value := val ]
		with: space root.
	checkable dispatchEvent: ToCheckableChangedEvent new.
	self assert: (received isKindOf: ToCheckableChangedEvent).
	self assert: theElement identicalTo: space root.
	self deny: value.
	received := nil.
	theElement := nil.
	value := nil.
	checkable checked: true.
	self assert: (received isKindOf: ToCheckableChangedEvent).
	self assert: theElement identicalTo: space root.
	self assert: value
]

{ #category : #tests }
TToLinkableTest >> testCheckFeatureWith [
 
	| checkable1 checkable2|
	checkable1 := ToCheckbox new labelText: 'XXXXX'; yourself.
	checkable2 := ToCheckbox new labelText: 'YYYYY'; yourself.
	checkable1 checkFeature: #checked with: checkable2.

	self deny: checkable1  isChecked.
	self deny: checkable2  isChecked.
	
	BlSpace simulateClickOn: checkable1.
	self assert: checkable1  isChecked.
	self assert: checkable2  isChecked.

	BlSpace simulateClickOn: checkable2.
	self assert: checkable1  isChecked.
	self deny: checkable2  isChecked


]

{ #category : #tests }
TToLinkableTest >> testCheckFeatureWith2 [
 
	| pane checkable1 checkable2 checkable3 checkable4 |
	checkable1 := ToCheckbox new labelText: 'XXXXX'; yourself.
	checkable2 := ToCheckbox new labelText: 'YYYYY'; yourself.
	checkable3 := ToCheckbox new labelText: 'ZZZZZ'; yourself.
	checkable4 := ToCheckbox new labelText: '00000'; yourself.
	
	pane := ToPane vertical.
	pane addChildren: {
			checkable1.
			checkable2.
			checkable3.
			checkable4 }.
			
	checkable1 checkFeature: #checked with: checkable2.
	checkable1 checkFeature: #checked with: checkable3.
	checkable3 checkFeature: #checked with: checkable4.

	self deny: checkable1  isChecked.
	self deny: checkable2  isChecked.
	self deny: checkable3  isChecked.
	self deny: checkable4  isChecked.
	

	BlSpace simulateClickOn: checkable1.

	self assert: checkable1  isChecked.
	self assert: checkable2  isChecked.
	self assert: checkable3  isChecked.
	self assert: checkable4  isChecked

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
TToLinkableTest >> testClickAction2 [

	| received value theElement |
	received := nil.
	element clickAction: [ :evt :obj :val |
			received := evt.
			theElement := obj.
			value := val ].
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: received notNil.
	self assert: value isNil.
	self assert: theElement identicalTo: element
]

{ #category : #tests }
TToLinkableTest >> testClickActionWith [

	| received value theElement |
	received := nil.
	element
		clickAction: [ :evt :obj :val |
				received := evt.
				theElement := obj.
				value := val ]
		with: space root.
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: received notNil.
	self assert: value isNil.
	self assert: theElement identicalTo: space root
]

{ #category : #tests }
TToLinkableTest >> testLinkCheckAction [
 
	| received prevReceived runCount checkable|
	received := nil.
	runCount := 0.
	checkable := ToCheckbox new labelText: 'XXXXX'; yourself.
	space root addChild: checkable.

	self assert: checkable linkedActions isEmpty.
	checkable linkCheckAction: [ :evt |
			received := evt.
			runCount := runCount + 1 ].
	self assert: checkable linkedActions size equals: 1.
	BlSpace simulateClickOn: checkable.
	self waitTestingSpaces.
	self assert: received notNil.
	self assert: runCount equals: 1.
	prevReceived := received.
	received := nil.
	checkable linkedActions do: [ :action | action run ].
	self assert: received isNil.
	self assert: runCount equals: 2
]

{ #category : #tests }
TToLinkableTest >> testLinkCheckAction2 [
 
	| received runCount checkable|
	received := nil.
	runCount := 0.
	checkable := ToCheckbox new labelText: 'XXXXX'; yourself.
	checkable linkCheckAction: [ :evt |
			received := evt.
			runCount := runCount + 1 ].
	self assert: checkable linkedActions size equals: 1.
	BlSpace simulateClickOn: checkable.
	self assert: runCount equals: 1.

	checkable linkedActions do: [ :action | action run ].
	space root addChild: checkable.
	self assert: received notNil.
	self waitTestingSpaces.
	self assert: received isNil.
	self assert: runCount equals: 2.



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
TToLinkableTest >> testNewCheckAction [

	| received prevReceived action passedInAction checkable |
	received := nil.
	passedInAction := false.
	checkable := ToCheckbox new labelText: 'XXXXX'; yourself.
	space root addChild: checkable.
	action := checkable newCheckAction: [ :evt |
			          received := evt.
			          passedInAction := true ].
	self assert: action notNil.
	BlSpace simulateClickOn: checkable.
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
TToLinkableTest >> testNewCheckActionOnGroup [

	| group groupContainer received theGroup theList |
	group := ToCheckableGroup new.
	group withStrictCheckingStrategy.
	{ 'Monday'. 'Tuesday'. 'Wednesday'. 'Thursday'. 'Friday' } do: [ :day |
			group register: (ToToggleButton new
					 labelText: day;
					 hMatchParent;
					 yourself) ].

	groupContainer := ToPane vertical.
	groupContainer
		newCheckAction: [ :evt :grp :list |
				received := evt.
				theGroup := grp.
				theList := list ]
		onGroup: group.

	groupContainer width: 150.
	groupContainer addChildren: group registeredCheckables.
	space root addChild: groupContainer.
	group registeredCheckables second checked: true.
	self waitTestingSpaces.
	self assert: received notNil.
	self assert: theGroup identicalTo: group.
	self assert: theList size equals: 1.
	self
		assert: theList first
		identicalTo: group registeredCheckables second
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
TToLinkableTest >> testRemoveLinkedAction [

	| action |
	action := element newClickAction: [ :evt |  ].
	self assert: element linkedActions size equals: 0.
	element addLinkedAction: action.
	self assert: element linkedActions size equals: 1.
	element removeLinkedAction: action.
	self assert: element linkedActions size equals: 0.


	
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
