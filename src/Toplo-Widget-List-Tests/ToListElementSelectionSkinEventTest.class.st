Class {
	#name : #ToListElementSelectionSkinEventTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> selectedSkinEventCountAfterRemove [
	" check that the skin select event is sent to the right node "

	space deferAndSettle: [
		listElement selecter deselectAll.
		listElement dataAccessor add: self statesOfAmerica first.
		listElement dataAccessor add: self statesOfAmerica second ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ listElement selecter selectIndex: 2 ].
	self assert: listElement nodeContainers size equals: 2.
	self assert: listElement selectionModel selectedIndexes equals: #( 2 ).

	space deferAndSettle: [ listElement dataAccessor removeAt: 1 ].
	self assert: listElement nodeContainers size equals: 1.
	self assert: listElement selectionModel selectedIndexes equals: #( 1 ).

	" the second node is selected then the first node is removed 
	-> the first node become selected but without selection changed event dispatching because of a shift selection command (the second nodeContainer is shift at the position 1)"
	
	self assert: listElement selectionMode selectionContainer children size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers first holder position equals: 1. 
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> selectedSkinEventCountAfterSelect [
	" check that the skin select event is sent to the right node "

	space deferAndSettle: [
		listElement dataAccessor add: self statesOfAmerica first.
		listElement dataAccessor add: self statesOfAmerica second ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ listElement selecter selectIndex: 2 ].
	self assert: listElement nodeContainers size equals: 2.

	space deferAndSettle: [ listElement selecter selectOnlyIndex: 1 ].
	self assert: listElement selectionMode selectionContainer children size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers first holder position equals: 1.
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> selectedSkinEventCountAfterSelect2 [
	" check that the skin select event is sent to the right node.
	After running testSelectedSkinEventCountAfterSelect, the holders selection flags are up-to-date 
	(the holder>>selectionNotificationMap is up to date). So the result is that the deselection is only applied once
	on the selected node "

	self selectedSkinEventCountAfterSelect.

	" here, the selected index is 1 because of #testSelectedSkinEventCountAfterSelect invocation"
	space deferAndSettle: [
		listElement selecter selectIndex: 2 .
		listElement selecter selectOnlyIndex: 1 ].
	self assert: listElement selectionMode selectionContainer children size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers size equals: 1.
	self assert: listElement selectionMode selectionContainer children first nodeContainers first holder position equals: 1.
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> selectedSkinEventCountAfterSelect3 [
	" check that the skin select event is sent to the right node.
	After running testSelectedSkinEventCountAfterSelect, the holders selection flags are up-to-date 
	(the holder>>selectionNotificationMap is up to date). So the result is that the deselection is only applied once
	on the selected node "

	" here, the selected index is 1 because of #testSelectedSkinEventCountAfterSelect invocation"
	space deferAndSettle: [
		listElement selecter selectOnlyIndex: 2 .
		listElement selecter selectOnlyIndex: 1 ].
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

	space deferAndSettle: [
		space root addChild: listElement.
		listElement nodeBuilder: [ :node :dataItem :holder |
			node addChild: (ToLabel text: dataItem) ] ]
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

	space deferAndSettle: [ listElement useInfiniteLayout: false ].
	self selectedSkinEventCountAfterRemove
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testFiniteSelectedSkinEventCountAfterSelect [
	" check that the skin select event is sent to the right node "

	space deferAndSettle: [ listElement useInfiniteLayout: false ].
	self selectedSkinEventCountAfterSelect
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testFiniteSelectedSkinEventCountAfterSelect2 [
	" check that the skin select event is sent to the right node.
	After running testSelectedSkinEventCountAfterSelect, the holders selection flags are up-to-date 
	(the holder>>selectionNotificationMap map is up to date). So the result is that the deselection is only applied once
	on the selected node "

	space deferAndSettle: [ listElement useInfiniteLayout: false ].
	self selectedSkinEventCountAfterSelect2
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testFiniteSelectedSkinEventCountAfterSelect3 [
	" check that the skin select event is sent to the right node.
	After running testSelectedSkinEventCountAfterSelect, the holders selection flags are up-to-date 
	(the holder>>selectionNotificationMap map is up to date). So the result is that the deselection is only applied once
	on the selected node "

	space deferAndSettle: [ listElement useInfiniteLayout: false ].
	self selectedSkinEventCountAfterSelect.

	space deferAndSettle: [ listElement requestFocus ].
	self selectedSkinEventCountAfterSelect3
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
	(the holder>>selectionNotificationMap map is up to date). So the result is that the deselection is only applied once
	on the selected node "

	self selectedSkinEventCountAfterSelect2
]

{ #category : #'test selection - skin' }
ToListElementSelectionSkinEventTest >> testInfiniteSelectedSkinEventCountAfterSelect3 [
	" check that the skin select event is sent to the right node.
	After running testSelectedSkinEventCountAfterSelect, the holders selection flags are up-to-date 
	(the holder>>selectionNotificationMap map is up to date). So the result is that the deselection is only applied once
	on the selected node "

	space deferAndSettle: [ listElement useInfiniteLayout: true ].
	self selectedSkinEventCountAfterSelect.

	space deferAndSettle: [ listElement requestFocus ].
	self selectedSkinEventCountAfterSelect3
]
