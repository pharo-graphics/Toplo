"
A TToLinkableTest is a test class for testing the behavior of TToLinkable
"
Class {
	#name : #TToElementWithActionPoolTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
TToElementWithActionPoolTest >> setUp [

	super setUp.
	element := ToElement new extent: 50 asPoint.
	space deferAndSettle: [ space root addChild: element ]
]

{ #category : #tests }
TToElementWithActionPoolTest >> testCheckAction [

	| received checkable |
	received := nil.
	checkable := ToCheckbox labelText: 'XXXXX'.
	checkable checkAction: [ :evt | received := evt ].
	space deferAndSettle: [ space root addChild: checkable ].

	checkable dispatchEvent: (ToCheckableChangedEvent new
			 checked: true;
			 yourself).
	self assert: (received isKindOf: ToCheckableChangedEvent).

	received := nil.
	checkable eventSimulator click.
	self assert: (received isKindOf: ToCheckableChangedEvent)
]

{ #category : #tests }
TToElementWithActionPoolTest >> testCheckActionWith [

	| received checkable value |
	received := nil.
	value := nil.
	checkable := ToCheckbox labelText: 'XXXXX'.
	space deferAndSettle: [ space root addChild: checkable ].
	checkable checkAction: [ :evt |
		received := evt.
		value := evt target isChecked ].
	checkable dispatchEvent: (ToCheckableChangedEvent checked: true).
	self assert: (received isKindOf: ToCheckableChangedEvent).
	self deny: value.
	received := nil.
	value := nil.
	checkable checked: true.
	self assert: (received isKindOf: ToCheckableChangedEvent).
	self assert: value
]

{ #category : #tests }
TToElementWithActionPoolTest >> testClickAction [

	| received |
	received := nil.
	element clickAction: [ :evt | received := evt ].
	element eventSimulator click.
	self assert: received notNil
	
]

{ #category : #tests }
TToElementWithActionPoolTest >> testClickAction2 [

	| received |
	received := nil.
	element clickAction: [ :evt |
			received := evt ].
	element eventSimulator click.
	self assert: received notNil
]

{ #category : #tests }
TToElementWithActionPoolTest >> testGroupCheckAction [

	| group received theGroup theList |
	group := ToCheckableGroupPane new.
	group withStrictCheckingStrategy.
	{ 'Monday'. 'Tuesday'. 'Wednesday'. 'Thursday'. 'Friday' } do: [ :day |
			group addChild: (ToToggleButton labelText: day) ].

	group
		groupCheckAction: [ :evt  |
				received := evt.
				theGroup := evt target.
				theList := evt checkedList ].

	group width: 150.
	space deferAndSettle: [
		space root addChild: group.
		group items second checked: true ].
	self assert: received notNil.
	self assert: theGroup identicalTo: group.
	self assert: theList size equals: 1.
	self
		assert: theList first
		identicalTo: group items second
]

{ #category : #tests }
TToElementWithActionPoolTest >> testNewCheckAction [

	| received prevReceived action passedInAction checkable |
	received := nil.
	passedInAction := false.
	checkable := ToCheckbox labelText: 'XXXXX'.
	action := checkable newCheckAction: [ :evt |
			          received := evt.
			          passedInAction := true ].
	self assert: action notNil.

	space deferAndSettle: [ space root addChild: checkable ].
	checkable eventSimulator click.
	self assert: received notNil.
	self assert: passedInAction.

	prevReceived := received.
	received := nil.
	passedInAction := false.
	space deferAndSettle: [ action requestNextRun ].
	self assert: received isNil.
	self assert: passedInAction.

	received := nil.
	passedInAction := false.
	space deferAndSettle: [ action requestNextRunWithEvent: prevReceived ].
	self assert: received equals: prevReceived.
	self assert: passedInAction
]

{ #category : #tests }
TToElementWithActionPoolTest >> testNewClickAction [

	| received prevReceived action passedInAction |
	received := nil.
	passedInAction := false.
	action := element newClickAction: [ :evt |
			          received := evt.
			          passedInAction := true ].
	self assert: action notNil.
	element eventSimulator click.
	self assert: received notNil.
	self assert: passedInAction.
	prevReceived := received.
	received := nil.
	passedInAction := false.
	action requestNextRun.
	self assert: received isNil.
	self assert: passedInAction.
	received := nil.
	passedInAction := false.
	action requestNextRunWithEvent: prevReceived.
	self assert: received equals: prevReceived.
	self assert: passedInAction
]

{ #category : #tests }
TToElementWithActionPoolTest >> testNewGroupCheckAction [

	| group received theGroup theList |
	group := ToCheckableGroupPane new.

	{ 'Monday'. 'Tuesday'. 'Wednesday'. 'Thursday'. 'Friday' } do: [ :day |
			group addChild: (ToToggleButton labelText: day) ].

	group newGroupCheckAction: [ :evt |
			received := evt.
			theGroup := evt target.
			theList := evt checkedList ].
	
	group width: 150.
	space deferAndSettle: [
		space root addChild: group.
		group items second checked: true ].
	" waited to update the data source "
	self assert: received notNil.
	self assert: theGroup identicalTo: group.
	self assert: theList size equals: 1.
	self assert: theList first identicalTo: group items second
]

{ #category : #tests }
TToElementWithActionPoolTest >> testRunCount [

	| actionLink count |
	count := 0.
	actionLink := element newClickAction: [ :evt | count := count + 1 ].
	self assert: actionLink runCount equals: 0.
	element eventSimulator click.
	self assert: actionLink runCount equals: count.
	self assert: actionLink runCount equals: 1
]

{ #category : #tests }
TToElementWithActionPoolTest >> testRunCount2 [

	| actionLink count |
	count := 0.
	actionLink := element newClickAction: [ :evt | count := count + 1 ].
	self assert: actionLink runCount equals: 0.
	element eventSimulator click.
	self assert: actionLink runCount equals: count.
	self assert: actionLink runCount equals: 1.
	(BlMouseProcessor dblClickDelay + 1 milliSecond) wait.
	element eventSimulator click.
	self assert: actionLink runCount equals: count.
	self assert: actionLink runCount equals: 2
]
