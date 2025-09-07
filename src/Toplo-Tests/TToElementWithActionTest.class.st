"
A TToLinkableTest is a test class for testing the behavior of TToLinkable
"
Class {
	#name : #TToElementWithActionTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
TToElementWithActionTest >> setUp [

	super setUp.
	element := ToElement new extent: 50 asPoint.
	space root addChild: element
]

{ #category : #tests }
TToElementWithActionTest >> testCheckAction [

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
TToElementWithActionTest >> testCheckActionWith [

	| received checkable value |
	received := nil.
	value := nil.
	checkable := ToCheckbox new
		             labelText: 'XXXXX';
		             yourself.
	space root addChild: checkable.
	checkable
		checkAction: [ :evt |
				received := evt.
				value := evt target isChecked ].
	checkable dispatchEvent: ToCheckableChangedEvent new.
	self assert: (received isKindOf: ToCheckableChangedEvent).
	self deny: value.
	received := nil.
	value := nil.
	checkable checked: true.
	self assert: (received isKindOf: ToCheckableChangedEvent).
	self assert: value
]

{ #category : #tests }
TToElementWithActionTest >> testClickAction [

	| received |
	received := nil.
	element clickAction: [ :evt | received := evt ].
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: received notNil
	
]

{ #category : #tests }
TToElementWithActionTest >> testClickAction2 [

	| received |
	received := nil.
	element clickAction: [ :evt |
			received := evt ].
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: received notNil
]

{ #category : #tests }
TToElementWithActionTest >> testGroupCheckAction [

	| group received theGroup theList |
	group := ToCheckableGroupPane new.
	group withStrictCheckingStrategy.
	{ 'Monday'. 'Tuesday'. 'Wednesday'. 'Thursday'. 'Friday' } do: [ :day |
			group addChild: (ToToggleButton new
					 labelText: day;
					 yourself) ].

	group
		groupCheckAction: [ :evt  |
				received := evt.
				theGroup := evt target.
				theList := evt checkedList ].

	group width: 150.
	space root addChild: group.
	group items second checked: true.
	self waitTestingSpaces.
	self assert: received notNil.
	self assert: theGroup identicalTo: group.
	self assert: theList size equals: 1.
	self
		assert: theList first
		identicalTo: group items second
]

{ #category : #tests }
TToElementWithActionTest >> testNewCheckAction [

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
TToElementWithActionTest >> testNewClickAction [

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
TToElementWithActionTest >> testNewGroupCheckAction [

	| group received theGroup theList |
	group := ToCheckableBarElement new.
	group withStrictCheckingStrategy.
	{ 'Monday'. 'Tuesday'. 'Wednesday'. 'Thursday'. 'Friday' } do: [ :day |
			group addItem: (ToToggleButton new
					 labelText: day;
					 yourself) ].

	group
		newGroupCheckAction: [ :evt  |
				received := evt.
				theGroup := evt target.
				theList := evt checkedList ].

	group width: 150.
	group uniformNodeWidth: true.
	space root addChild: group.
	group items second checked: true.
	self waitTestingSpaces.
	self assert: received notNil.
	self assert: theGroup identicalTo: group.
	self assert: theList size equals: 1.
	self
		assert: theList first
		identicalTo: group items second
]

{ #category : #tests }
TToElementWithActionTest >> testNewGroupCheckAction2 [

	| group received theGroup theList |
	group := ToCheckableListElement new.
	group withStrictCheckingStrategy.
	group addAllItems:
		({ 'Monday'. 'Tuesday'. 'Wednesday'. 'Thursday'. 'Friday' }
			 collect: [ :day |
					 ToToggleButton new
						 labelText: day;
						 yourself ]).

	group matchParent.
	self waitTestingSpaces.
	group newGroupCheckAction: [ :evt |
			received := evt.
			theGroup := evt target.
			theList := evt checkedList ].

	space root addChild: group.
	" wait to update the data source "
	self waitTestingSpaces.
	group items second checked: true.
	" wait to let the space run the task that dispatch a ToCheckableGroupChangedEvent "
	self waitTestingSpaces.
	self assert: received notNil.
	self assert: theGroup identicalTo: group.
	self assert: theList size equals: 1.
	self assert: theList first identicalTo: group items second
]

{ #category : #tests }
TToElementWithActionTest >> testRunCount [

	| actionLink count |
	count := 0.
	actionLink := element newClickAction: [ :evt | count := count + 1 ].
	self assert: actionLink runCount equals: 0.
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: actionLink runCount equals: count.
	self assert: actionLink runCount equals: 1.
	
]

{ #category : #tests }
TToElementWithActionTest >> testRunCount2 [

	| actionLink count |
	count := 0.
	actionLink := element newClickAction: [ :evt | count := count + 1 ].
	self assert: actionLink runCount equals: 0.
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: actionLink runCount equals: count.
	self assert: actionLink runCount equals: 1.
	(BlMouseProcessor dblClickDelay + 1 milliSecond) wait.
	BlSpace simulateClickOn: element.
	self waitTestingSpaces.
	self assert: actionLink runCount equals: count.
	self assert: actionLink runCount equals: 2
]
