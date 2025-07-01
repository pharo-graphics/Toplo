Class {
	#name : #ToListElementSelectionChangedEventTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #accessing }
ToListElementSelectionChangedEventTest >> statesOfAmerica [

	^ { #Alabama. #Alaska. #Arizona. #Arkansas. #California. #Colorado.
		#Connecticut. #Delaware. #Florida. #Georgia. #Hawaii. #Idaho. #'Illinois Indiana'.
		#Iowa. #Kansas. #Kentucky. #Louisiana. #Maine. #Maryland. #Massachusetts.
		#Michigan. #Minnesota. #Mississippi. #Missouri. #Montana. #Nebraska.
		#Nevada. #'New Hampshire'. #'New Jersey'. #'New Mexico'.
		#'New York'. #'North Carolina'. #'North Dakota'. #Ohio. #Oklahoma.
		#Oregon. #'Pennsylvania Rhode Island'. #'South Carolina'.
		#'South Dakota'. #Tennessee. #Texas. #Utah. #Vermont. #Virginia.
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }.
]

{ #category : #tests }
ToListElementSelectionChangedEventTest >> testPrimarySelectionChangedEventDispatch [
	" event dispateched when a selected node is removed "

	| l dispatchedEvent |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	l forceLayout.
	l selecter selectOnlyIndex: 3.
	" have to pulse space to get selection actually updated "
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	self
		assert: l selectionMode selectionContainer children size
		equals: 1.
	l
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | dispatchedEvent := event ].
	dispatchedEvent := nil.
	l dataAccessor removeAt: 3.
	" have to pulse to get an updated datasource plus oupdated selection model "
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: {  }.
	self assert: l selectionMode selectionContainer children isEmpty.
	self assert: dispatchedEvent notNil
]

{ #category : #tests }
ToListElementSelectionChangedEventTest >> testPrimarySelectionChangedEventDispatch1 [
	" event dispateched when a selected node is removed "

	| l dispatchedEvent |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self waitTestingSpaces.
	l selecter selectOnlyIndex: 3.
	self waitTestingSpaces.
	l
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | dispatchedEvent := event ].
	dispatchedEvent := nil.
	l dataAccessor removeAt: 3.
	" have to pulse to get an updated datasource plus oupdated selection model "
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: {  }.
	self assert: l selectionMode selectionContainer children isEmpty.
	self assert: dispatchedEvent notNil
]

{ #category : #tests }
ToListElementSelectionChangedEventTest >> testPrimarySelectionChangedEventDispatchAfterRemoveAll [
	" event dispateched when a selected node is removed "

	| l dispatchedEvent |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	l forceLayout.
	l selecter selectOnlyIndex: 3.
	" have to pulse space to get selection actually updated "
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	self
		assert: l selectionMode selectionContainer children size
		equals: 1.
	l
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | dispatchedEvent := event ].
	dispatchedEvent := nil.
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	l dataAccessor removeAll.
	" have to pulse to get an updated datasource plus oupdated selection model "
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: {  }.
	self assert: l selectionMode selectionContainer children isEmpty.
	self assert: dispatchedEvent notNil
]
