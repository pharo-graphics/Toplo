Class {
	#name : #ToListElementSelectionSkinEventTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'listElement',
		'receivedSelectedEvents',
		'receivedDeselectedEvents'
	],
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> selectedSkinEventCountAfterRemove [
	" check that the skin select event is sent to the right node "

	listElement selecter deselectAll.
	self waitTestingSpaces.
	space applyAllSkinPhases.
	listElement dataAccessor add: self statesOfAmerica first.
	listElement dataAccessor add: self statesOfAmerica second.
	listElement selecter selectIndex: 2.
	self waitTestingSpaces.
	space applyAllSkinPhases.
	listElement forceLayout.
	self assert: listElement nodeContainers size equals: 2.
	self assert: listElement selectionModel selectedIndexes equals: #( 2 ).

	receivedSelectedEvents := OrderedCollection new.
	receivedDeselectedEvents := OrderedCollection new.

	listElement dataAccessor removeAt: 1.
	space applyAllSkinPhases.
	self waitTestingSpaces.
 	listElement forceLayout.
	self assert: listElement nodeContainers size equals: 1.
	self assert: listElement selectionModel selectedIndexes equals: #( 1 ).

	" the second node is selected then the first node is removed 
	-> the first node become selected but without selection changed event dispatching because of a shift selection command (the second nodeContainer is shift at the position 1)"
	self assert: receivedSelectedEvents size equals: 0.
	self assert: receivedDeselectedEvents size equals: 0.
	
	self assert: listElement selectionMode selectionContainer children size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers first holder position equals: 1. 
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> selectedSkinEventCountAfterSelect [
	" check that the skin select event is sent to the right node "

	receivedSelectedEvents := OrderedCollection new.
	receivedDeselectedEvents := OrderedCollection new.

	listElement dataAccessor add: self statesOfAmerica first.
	listElement dataAccessor add: self statesOfAmerica second.
	listElement selecter selectIndex: 2.

	self waitTestingSpaces.
	listElement forceLayout.
	self assert: listElement nodeContainers size equals: 2.
	space applyAllSkinPhases.
	self deny: listElement isFocused.
	self assert: receivedSelectedEvents size equals: 1.
	receivedSelectedEvents do: [ :evt |
		self assert: evt currentTarget holder position equals: 2 ].
	self assert: receivedDeselectedEvents size equals: 1.
	listElement selecter selectOnlyIndex: 1.
	self waitTestingSpaces.
	space applyAllSkinPhases.
	 listElement forceLayout.

	self assert: receivedDeselectedEvents size equals: 2.
	receivedDeselectedEvents withIndexDo: [ :evt :idx |
		self assert: evt currentTarget holder position equals: idx ].
	listElement forceLayout.
	self assert: listElement selectionMode selectionContainer children size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers first holder position equals: 1.

]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> selectedSkinEventCountAfterSelect2 [
	" check that the skin select event is sent to the right node.
	After running testSelectedSkinEventCountAfterSelect, the holders selection flags are up-to-date 
	(the holder>>notifiedSelected flag is not nil). So the result is that the deselection is only applied once
	on the selected node "

	self selectedSkinEventCountAfterSelect.
	receivedSelectedEvents := OrderedCollection new.
	receivedDeselectedEvents := OrderedCollection new.

	" here, the selected index is 1 because of #testSelectedSkinEventCountAfterSelect invocation"
	listElement selecter selectIndex: 2.
	self waitTestingSpaces.
	space applyAllSkinPhases.
	listElement forceLayout.
	
	self assert: receivedSelectedEvents size equals: 1.
	receivedSelectedEvents do: [ :evt |
		self assert: evt currentTarget holder position equals: 2 ].
	self assert: receivedDeselectedEvents size equals: 0.
	listElement selecter selectOnlyIndex: 1.
	self waitTestingSpaces.
	space applyAllSkinPhases.
	
	self assert: receivedDeselectedEvents size equals: 1.
	receivedDeselectedEvents withIndexDo: [ :evt :idx |
		self assert: evt currentTarget holder position equals: 2 ].
	listElement forceLayout.
	self assert: listElement selectionMode selectionContainer children size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers first holder position equals: 1.

]

{ #category : #running }
ToListElementSelectionSkinEventTest >> setUp [

	super setUp.
	listElement := ToListElement new.
	listElement innerElement.
	listElement fitContent.

	space root addChild: listElement.
	receivedSelectedEvents := OrderedCollection new.
	receivedDeselectedEvents := OrderedCollection new.
	listElement nodeBuilder: [ :node :dataItem :holder |
			node addChild: (ToLabel text: dataItem).
			node
				addEventHandlerOn: ToSelectedSkinEvent
				do: [ :event | receivedSelectedEvents add: event copy].
			node
				addEventHandlerOn: ToDeselectedSkinEvent
				do: [ :event | receivedDeselectedEvents add: event copy ] ].
	self waitTestingSpaces.
	listElement forceLayout 
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
ToListElementSelectionSkinEventTest >> testFiniteSelectedSkinEventCountAfterRemove [
	" check that the skin select event is sent to the right node "

	listElement useInfiniteLayout: false.
	self waitTestingSpaces.
	self selectedSkinEventCountAfterRemove
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testFiniteSelectedSkinEventCountAfterSelect [
	" check that the skin select event is sent to the right node "

	listElement useInfiniteLayout: false.
	self waitTestingSpaces.

	self selectedSkinEventCountAfterSelect
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testFiniteSelectedSkinEventCountAfterSelect2 [
	" check that the skin select event is sent to the right node.
	After running testSelectedSkinEventCountAfterSelect, the holders selection flags are up-to-date 
	(the holder>>notifiedSelected flag is not nil). So the result is that the deselection is only applied once
	on the selected node "

	listElement useInfiniteLayout: false.
	self waitTestingSpaces.
	self selectedSkinEventCountAfterSelect2
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testInfiniteSelectedSkinEventCountAfterRemove [
	" check that the skin select event is sent to the right node "

	self selectedSkinEventCountAfterRemove
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testInfiniteSelectedSkinEventCountAfterSelect [
	" check that the skin select event is sent to the right node "

	self selectedSkinEventCountAfterSelect
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testInfiniteSelectedSkinEventCountAfterSelect2 [
	" check that the skin select event is sent to the right node.
	After running testSelectedSkinEventCountAfterSelect, the holders selection flags are up-to-date 
	(the holder>>notifiedSelected flag is not nil). So the result is that the deselection is only applied once
	on the selected node "

	self selectedSkinEventCountAfterSelect2
]
