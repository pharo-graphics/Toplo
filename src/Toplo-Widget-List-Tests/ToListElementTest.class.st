"
A ToListElementTest is a test class for testing the behavior of ToListElement
"
Class {
	#name : #ToListElementTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #'test node - enablement' }
ToListElementTest >> listWithRemoveRowButtons [

	| list |
	list := ToListElement new.
	space root addChild: list.
	list nodeBuilder: [ :node :dataItem :holder |
		| line remBut filler |
		line := ToPane horizontal id: #row.
		remBut := ToIconicRemoveButton new id: #'remove-button-' , holder position asString.
		remBut constraintsDo: [ :c | c linear vertical alignCenter ].
		remBut addEventHandler: (BlEventHandler
				 on: BlClickEvent
				 do: [ :event |
					 event consume.
					 holder listElement dataAccessor removeAt: holder position ]).
		filler := ToElement new
			          matchParent;
			          id: #filler.
		line addChild: filler.
		line addChild: remBut.
		node addChild: line ].
	^ list
]

{ #category : #accessing }
ToListElementTest >> statesOfAmerica [

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

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testDataRemovedWhenNodeRemoved [

	| list but remButtons fillers |
	list := self listWithRemoveRowButtons.
	list dataAccessor addAll: (1 to: 2).
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	fillers := (list allChildrenBreadthFirstSelect: [ :child |
		            child id asString = 'filler' ]) asOrderedCollection.
	remButtons := (list allChildrenBreadthFirstSelect: [ :child |
		               child id asString beginsWith: 'remove-button' ])
		              asOrderedCollection.
	" first click on the list to set the focus "
	BlSpace simulateClickOn: fillers first.
	but := remButtons removeFirst.
	BlSpace simulateClickOn: but.
	self waitTestingSpaces.
	but := remButtons removeFirst.
	BlSpace simulateClickOn: but.
	self assert: list dataAccessor isEmpty.
	self assert:
		list primarySelectionMode selectionOption selectionElements isEmpty
]

{ #category : #'test selection - mode' }
ToListElementTest >> testDisable [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l matchParent.
	l dataAccessor addAll: { #A. #B. #C }.
	l selecter selectIndex: 2.
	l secondarySelecter selectIndex: 3.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: { 2 }.
	self assert: l secondarySelectionModel selectedIndexes equals: { 3 }.
	l disable.
	self waitTestingSpaces.
	self assert: l isDisabled.
	self assert: l selectionModel isEmpty.
	self assert: l secondarySelectionModel isEmpty.
	l nodesDo: [ :n | self assert: n isDisabled ]
	
]

{ #category : #'test selection - mode' }
ToListElementTest >> testDisabledSelectionModel [

	| l |
	l := ToListElement new.
	self assert: (l disabledSelectionMode selectionModel isKindOf:
			 ToSubSelectionModel).
	self
		assert: l disabledSelectionMode selectionModel
		identicalTo: l disabledSelecter selectionModel.
	self
		assert: l disabledSelectionModel
		identicalTo: l disabledSelecter selectionModel
]

{ #category : #'test selection - mode' }
ToListElementTest >> testDisabledSelectionModel2 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l dataAccessor addAll: { #A. #B. #C }.
	l selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: { 2 }.
	self
		assert: l disabledSelectionMode selectionModel
		identicalTo: l disabledSelecter selectionModel.
	self
		assert: l disabledSelectionModel
		identicalTo: l disabledSelecter selectionModel
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithFiveNodes [

	| l |
	l := ToListElement new.
	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	l innerElement firstChild holder disabled: true.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth' afterIndex: 2.
	l dataAccessor addFirst: 'fifth'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithFourNodes [

	| l |
	l := ToListElement new.
	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	l innerElement firstChild disabled: true.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth' afterIndex: 2.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithFourNodes2 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l dataAccessor add: 'first'.
	l dataAccessor add: 'second'.
	self waitTestingSpaces.
	l nodes second disabled: true.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithOneNode [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l dataAccessor add: 'first'.
	self waitTestingSpaces.
	self assert: l nodes size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithThreeNodes [

	| l |
	l := ToListElement new.
	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l innerElement firstChild holder disabled: true.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor add: 'third'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithTwoNodes [

	| l |
	l := ToListElement new.
	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithTwoNodes2 [

	| l |
	l := ToListElement new.
	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodes size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l nodes first disabled: true.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithTwoNodes3 [

	| l |
	l := ToListElement new.
	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodes size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l nodes first disabled: true.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	self assert: l nodes first isDisabled.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test selection - event' }
ToListElementTest >> testDoubleListsSelectionEvents [

	| panel list1 list2 tabSize |
	panel := ToPane new.
	space root addChild: panel.
	panel matchParent.
	tabSize := 2.
	list1 := ToListElement new.
	list2 := ToListElement new.
	1 to: tabSize do: [ :i |
	list1 dataAccessor add: 'Hello ' , i asString ].
	1 to: tabSize do: [ :i |
	list2 dataAccessor add: 'Goodbye ' , i asString ].
	list1 addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :e |
				 list2 selecter deselectAll.
				 e currentTarget selectionModel selectedIndexesDo: [ :idx |
					 list2 selecter selectIndex: idx ].
				 self waitTestingSpaces ]).
	panel addChild: list1.
	panel addChild: list2.
	list1 selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: (list1 selectionModel containsIndex: 1).
	self assert: (list2 selectionModel containsIndex: 1).

	list2 selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: (list2 selectionModel containsIndex: 2)
]

{ #category : #tests }
ToListElementTest >> testEmptyList [

	| l |
	l := ToListElement new.
	l fitContent.
	self assert: l nodes identicalTo: l innerElement children.
	self assert: l selecter selectedIndexes isEmpty.
	self assert: l selectionModel underlyingModel isEmpty.
	self assert: l secondarySelectionModel underlyingModel isEmpty.	
	self assert: l unselectableSelectionModel underlyingModel isEmpty.
	self assert: l disabledSelectionModel underlyingModel isEmpty.
	self assert: l disabledSelectionModel underlyingModel isEmpty.
	self assert: l hiddenSelectionModel underlyingModel isEmpty.
	self assert: l contextMenuSelectionModel underlyingModel isEmpty
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testEmptyListAddOrRemoveNextInSelection [

	| l |
	l := ToListElement new.

	l fitContent.
	self assert: l dataAccessor isEmpty.
	l forceLayout.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: l selecter nextSelectableIndex.
	self assert: l selecter currentIndex isZero
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testEmptyListAddOrRemovePreviousInSelection [

	| l |
	l := ToListElement new.
	l fitContent.
	self assert: l dataAccessor isEmpty.
	l forceLayout.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: l selecter previousSelectableIndex.
	l selecter scrollToDataSourcePosition: l selecter currentIndex.
	self assert: l selecter currentIndex isZero
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testEmptyListSelectNextInSelection [

	| l |
	l := ToListElement new.

	l fitContent.
	self assert: l dataAccessor isEmpty.
	l forceLayout.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: l selecter nextSelectableIndex.
	self assert: l selecter currentIndex isZero.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: l selecter nextSelectableIndex.
	self assert: l selecter currentIndex isZero.
	self assert: l selectionModel isEmpty
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testEmptyListSelectPreviousInSelection [

	| l |
	l := ToListElement new.

	l fitContent.
	self assert: l dataAccessor isEmpty.
	l forceLayout.
	l selecter selectIndex: l selecter previousSelectableIndex.
	l selecter selectIndex: l selecter previousSelectableIndex.
	l selecter scrollToDataSourcePosition: l selecter currentIndex.
	self assert: l selecter currentIndex isZero.
	self assert: l selectionModel isEmpty
]

{ #category : #'test selection - mode' }
ToListElementTest >> testEnable [

	| l |

	l := ToListElement new.
	space root addChild: l.

	l matchParent.
	l dataAccessor addAll: { #A. #B. #C }.
	l selecter selectIndex: 2.
	l secondarySelecter selectIndex: 3.
	l disable.
	self waitTestingSpaces.
	self assert: l isDisabled.
	self assert: l selectionModel isEmpty.
	self assert: l secondarySelectionModel isEmpty.
	l nodesDo: [ :n | self assert: n isDisabled ].
	l enable.
	self assert: l isEnabled.
	self assert: l selectionModel isEmpty.
	self assert: l secondarySelectionModel isEmpty.
	l nodesDo: [ :n | self deny: n isDisabled ].

	
	
]

{ #category : #'test selection - mode' }
ToListElementTest >> testHiddenSelectionModel [

	| l |
	l := ToListElement new.
	self assert: (l hiddenSelectionMode selectionModel isKindOf:
			 ToSubSelectionModel).
	self
		assert: l hiddenSelectionMode selectionModel
		identicalTo: l hiddenSelecter selectionModel.
	self
		assert: l hiddenSelectionModel
		identicalTo: l hiddenSelecter selectionModel
]

{ #category : #'test selection - mode' }
ToListElementTest >> testListElementWithFiveDefaultSelectionMode [

	| l |
	l := ToListElement new.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l dataAccessor size equals: 5
]

{ #category : #'test node - enablement' }
ToListElementTest >> testMakeDisabledUnselectable [

	| l |
	l := ToListElement new.
	l selectionMode makeDisabledUnselectable: true.
	space root addChild: l.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	l disabledSelecter selectIndex: 3.
	self waitTestingSpaces.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	self assert: l unselectableSelecter selectedIndexes equals: {  }.
	l selecter selectIndex: 3.
	self waitTestingSpaces.
	self assert: l selecter selectedIndexes equals: {  }.
	l selectionMode makeDisabledUnselectable: false.
	l selecter selectIndex: 3.
	self waitTestingSpaces.
	self waitTestingSpaces.
	self assert: l selecter selectedIndexes equals: { 3 }.

]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testNodeDeselectedWhenNodeRemoved [

	| list fillers remButtons but |
	list := self listWithRemoveRowButtons.
	list dataAccessor addAll: (1 to: 2).
	space applyAllSkinInstallers.
	space root forceLayout.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	remButtons := (list allChildrenBreadthFirstSelect: [ :child |
		               child id asString beginsWith: 'remove-button' ])
		              asOrderedCollection.
	fillers := (list selectChildrenWithId: #filler) asOrderedCollection.
	BlSpace simulateMouseDownOn: fillers first.
	BlSpace simulateMouseUpOn: fillers first.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert:
		list primarySelectionMode selectionOption selectionElements size
		equals: 1.
	but := remButtons at: 2.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert:
		list primarySelectionMode selectionOption selectionElements size
		equals: 1
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testNodeDeselectedWhenNodeRemoved2 [

	| list fillers but |
	list := self listWithRemoveRowButtons.
	list dataAccessor addAll: (1 to: 2).
	space applyAllSkinInstallers.
	space root forceLayout.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	fillers := (list selectChildrenWithId: #filler) asOrderedCollection.
	BlSpace simulateMouseDownOn: fillers first.
	BlSpace simulateMouseUpOn: fillers first.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert:
		list primarySelectionMode selectionOption selectionElements size
		equals: 1.
	but := list childWithId: #'remove-button-1'.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes isEmpty.
	self assert:
		list primarySelectionMode selectionOption selectionElements isEmpty
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testNodeDeselectedWhenNodeRemoved3 [

	| list fillers but |
	list := self listWithRemoveRowButtons.
	list dataAccessor addAll: (1 to: 2).
	space applyAllSkinInstallers.
	space root forceLayout.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	fillers := (list selectChildrenWithId: #filler) asOrderedCollection.
	BlSpace simulateMouseDownOn: fillers first.
	BlSpace simulateMouseUpOn: fillers first.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert:
		list primarySelectionMode selectionOption selectionElements size
		equals: 1.
	but := list childWithId: #'remove-button-1'.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes isEmpty.
	but := list childWithId: #'remove-button-2'.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 0.
	self assert: list selectionModel selectedIndexes isEmpty.
	self assert:
		list primarySelectionMode selectionOption selectionElements isEmpty
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testNodeDeselectedWhenNodeRemoved4 [

	| list fillers but |
	list := self listWithRemoveRowButtons.
	list dataAccessor addAll: (1 to: 2).
	space applyAllSkinInstallers.
	space root forceLayout.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	fillers := (list selectChildrenWithId: #filler) asOrderedCollection.
	BlSpace simulateMouseDownOn: fillers first.
	BlSpace simulateMouseUpOn: fillers first.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	but := list childWithId: #'remove-button-2'.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert:
		list primarySelectionMode selectionOption selectionElements size
		equals: 1.
	but := list childWithId: #'remove-button-1'.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 0.
	self assert: list selectionModel selectedIndexes isEmpty.
	self assert:
		list primarySelectionMode selectionOption selectionElements isEmpty
]

{ #category : #tests }
ToListElementTest >> testOneSpecifcNode [

	| l |
	l := ToSpecificListElementForTest new.
	l dataAccessor add: 'first'.
	self waitTestingSpaces.
	self assert: l dataSource first equals: 'first'.
	" no node since the list is not added in a space "
	self assert: l innerElement children size equals: 0.
	self assert: l nodes identicalTo: l innerElement children.
	self assert: l nodes size equals: 0.
	" adding the list in the space consequence is a layout computing which update the list nodes"
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l innerElement firstChild class identicalTo: ToSpecificListNodeForTest.	
	self assert: l nodes first class identicalTo: ToSpecificListNodeForTest.	
	self assert: l nodes first holder class identicalTo: ToSpecificListNodeHolderForTest.	
	self assert: l nodes first children size equals: 1.	
	self assert: l nodes first firstChild class identicalTo: ToLabel.	
	self assert: l nodes first firstChild text asString equals: '1:first'.	
	self assert: l nodes first holder num equals: 1.	
	self assert: l nodes first holder dataItem equals: 'first'
]

{ #category : #'test - selection changed event' }
ToListElementTest >> testPrimarySelectionChangedEventDispatch [
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

{ #category : #'test - selection changed event' }
ToListElementTest >> testPrimarySelectionChangedEventDispatch1 [
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

{ #category : #'test - selection changed event' }
ToListElementTest >> testPrimarySelectionChangedEventDispatchAfterRemoveAll [
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

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testRemoveAll [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l innerElement extent: 800 @ 600.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 5.
	l selecter selectOnlyIndex: 2.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 2 ).
	l dataAccessor removeAll.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 0.
	self assert: l selectionModel selectedIndexes isEmpty
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testSelectAndScrollToNext [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l dataAccessor size equals: 5.
	l forceLayout.
	l selecter selectIndex: 4.
	l selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: l selecter currentIndex equals: 2.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 2 4 ).
	l selecter selectIndex: l selecter nextSelectableIndex.
	l selecter scrollToDataSourcePosition: l selecter currentIndex.
	self waitTestingSpaces.
	self assert: l selecter currentIndex equals: 3.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 2 3 4 ).
	l selecter selectIndex: l selecter nextSelectableIndex.
	l selecter scrollToDataSourcePosition: l selecter currentIndex.
	self waitTestingSpaces.
	self assert: l selecter currentIndex equals: 4.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 2 3 4 )
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testSelectAndScrollToPrevious [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l dataAccessor size equals: 5.
	l selecter selectIndex: 4.
	self waitTestingSpaces.
	l forceLayout.
	self assert: l selecter currentIndex equals: 4.
	self assert: l selectionModel selectedIndexes asArray equals: #( 4 ).
	l selecter selectIndex: l selecter previousSelectableIndex.
	l selecter scrollToDataSourcePosition: l selecter currentIndex.
	self waitTestingSpaces.
	self assert: l selecter currentIndex equals: 3.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 3 4 ).
	l selecter selectIndex: l selecter previousSelectableIndex.
	l selecter scrollToDataSourcePosition: l selecter currentIndex.
	self waitTestingSpaces.
	self assert: l selecter currentIndex equals: 2.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 2 3 4 )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionAfterLastRemoval [

	| l |
	l := ToListElement new.
	l secondarySelectionMode enabled: false.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l selectionModel selectedIndexes isEmpty.
	l selecter selectIndexes: #( 5 ).
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 5 ).
	self waitTestingSpaces.
	l dataAccessor removeAt: 5.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #(  )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterInsert [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	l selecter selectOnlyIndex: 3.
	self waitTestingSpaces.
	self assert: l selecter currentIndex equals: 3.
	l dataAccessor add: (self statesOfAmerica at: 6) afterIndex: 1.
	self waitTestingSpaces.
	self assert: l selecter currentIndex equals: 3.
	self waitTestingSpaces.
	self assert: l selectionModel lastIndex equals: 4
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterInsert1 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l dataAccessor size equals: 5.
	l selecter selectOnlyIndex: 3.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	self assert: l selecter currentIndex equals: 3.
	l forceLayout.
	self assert: l innerElement children size equals: 5.
	l dataAccessor addAllFirst: (self statesOfAmerica copyFrom: 6 to: 10).
	self assert: l dataAccessor size equals: 10.
	self assert: l innerElement children size equals: 5.
	self waitTestingSpaces.
	self assert: l selectionModel lastIndex equals: 8
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterInsert3 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	l forceLayout.
	self assert: l selectionModel isEmpty.
	l selecter selectIndexes: #( 3 4 ).
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 3 4 ).
	self assert: l selecter currentIndex equals: 4.
	l dataAccessor add: (self statesOfAmerica at: 6) afterIndex: 1.
	self assert: l selecter currentIndex equals: 4.
	self assert: l selecter currentIndex equals: 4.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 4 5 )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	l selecter selectOnlyIndex: 3.
	self waitTestingSpaces.
	l dataAccessor removeAt: 2.

	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: { 2 }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove1 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	l forceLayout.
	l selecter selectOnlyIndex: 3.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	l dataAccessor removeAll.
	self waitTestingSpaces.
	self assert: l dataAccessor size equals: 0.
	self assert: l selectionModel isEmpty
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove2 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l dataAccessor size equals: 5.
	self waitTestingSpaces.
	self assert: l selectionModel isEmpty.
	l selecter selectOnlyIndex: 3.
	self waitTestingSpaces.
	self assert: l selecter currentIndex equals: 3.
	l dataAccessor removeAt: 4.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: { 3 }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove3 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l selectionModel selectedIndexes isEmpty.
	l selecter selectIndexes: #( 3 4 ).
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 3 4 ).
	l dataAccessor removeAt: 2.
	self waitTestingSpaces.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 2 3 )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove4 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self waitTestingSpaces.
	self assert: l dataAccessor size equals: 5.
	self assert: l selectionModel selectedIndexes isEmpty.
	l selecter selectIndexes: #( 2 ).
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 2 ).
	l dataAccessor removeAt: 2.
	self waitTestingSpaces.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes isEmpty
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove5 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l selectionModel selectedIndexes isEmpty.
	l selecter selectIndexes: #( 3 4 ).
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 3 4 ).
	l dataAccessor removeAt: 3.
	self waitTestingSpaces.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 3 )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove6 [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l selectionModel selectedIndexes isEmpty.
	l selecter selectIndexes: #( 3 4 ).
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 3 4 ).
	l dataAccessor removeAt: 3.
	l dataAccessor removeAt: 3.
	self waitTestingSpaces.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #(  )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionWithOneNode [

	| l |
	l := ToListElement new.
	l dataAccessor removeAll.
	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 1.
	self assert: l selectionModel selectedIndexes equals: { 1 }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionWithTwoNodes [

	| l |
	l := ToListElement new.
	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 2.
	self assert: l selecter selectedIndexes equals: { 2 }
]

{ #category : #'test selection - mode' }
ToListElementTest >> testUnselectableSelectionModel [

	| l |
	l := ToListElement new.
	self assert: (l unselectableSelectionMode selectionModel isKindOf:
			 ToSubSelectionModel).
	self
		assert: l unselectableSelectionMode selectionModel
		identicalTo: l unselectableSelecter selectionModel.
	self
		assert: l unselectableSelectionModel
		identicalTo: l unselectableSelecter selectionModel
]
