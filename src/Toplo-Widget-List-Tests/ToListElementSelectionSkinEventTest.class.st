Class {
	#name : #ToListElementSelectionSkinEventTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'listElement',
		'receivedSelectedEvents',
		'receivedDeselectedEvents',
		'action',
		'selectionCounts'
	],
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #running }
ToListElementSelectionSkinEventTest >> setUp [

	super setUp.
	listElement := ToListElement new.
	listElement nodeManager nodeHolderFactory: [
		ToNodeHolderForSkinEventTest new ].
	space root addChild: listElement.
	listElement fitContent.
	receivedSelectedEvents := OrderedCollection new.
	receivedDeselectedEvents := OrderedCollection new.
	selectionCounts := IdentityDictionary new.
	action := [ :holder |
		          | count |
		          holder notifiedSelected ifFalse: [
				          count := selectionCounts
					                   at: holder position
					                   ifPresent: [ :c | c + 1 ]
					                   ifAbsent: [ 1 ].
				          selectionCounts at: holder position put: count ] ].
	listElement nodeBuilder: [ :node :dataItem :holder |
			node addChild: (ToLabel text: dataItem).
			node userData at: #testAction put: [ action value: holder ].
			node
				addEventHandlerOn: ToSelectedSkinEvent
				do: [ :event | receivedSelectedEvents add: event ].
			node
				addEventHandlerOn: ToDeselectedSkinEvent
				do: [ :event | receivedDeselectedEvents add: event ] ]
]

{ #category : #accessing }
ToListElementSelectionSkinEventTest >> statesOfAmerica [

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

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testSelectedSkinEventCountAfterRemove [
	" check that the skin select event is sent to the right node "


	listElement dataAccessor add: self statesOfAmerica first.
	listElement dataAccessor add: self statesOfAmerica second.
	listElement selecter selectIndex: 2.

	self waitTestingSpaces.
	space applyAllSkinPhases.

	receivedSelectedEvents := OrderedCollection new.
	receivedDeselectedEvents := OrderedCollection new.
	selectionCounts := IdentityDictionary new.

	listElement dataAccessor removeAt: 1.
	self waitTestingSpaces.
	" the second node is selected then the first node is removed 
	-> the first node become selected "
	self assert: (selectionCounts includesKey: 2) not.
	self assert: (selectionCounts at: 1) equals: 1.
	
	self assert: receivedSelectedEvents size equals: 1.
	receivedSelectedEvents do: [ :evt |
		self assert: evt currentTarget holder position equals: 1 ].
	self assert: receivedDeselectedEvents size equals: 1.
	receivedDeselectedEvents do: [ :evt |
		self assert: evt currentTarget holder position equals: 1 ]
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testSelectedSkinEventCountAfterSelect [
	" check that the skin select event is sent to the right node "

	receivedSelectedEvents := OrderedCollection new.
	receivedDeselectedEvents := OrderedCollection new.
	selectionCounts := IdentityDictionary new.

	listElement dataAccessor add: self statesOfAmerica first.
	listElement dataAccessor add: self statesOfAmerica second.
	listElement selecter selectIndex: 2.

	self waitTestingSpaces.
	space applyAllSkinPhases.
	self deny: listElement isFocused.
	self assert: (selectionCounts includesKey: 2).
	self assert: (selectionCounts includesKey: 1) not.
	self assert: (selectionCounts at: 2) equals: 1.
	
	self assert: receivedSelectedEvents size equals: 1.
	receivedSelectedEvents do: [ :evt |
		self assert: evt currentTarget holder position equals: 2 ].
	self assert: receivedDeselectedEvents size equals: 0.
]
