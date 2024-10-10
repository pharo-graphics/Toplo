"
A ToListElementTest is a test class for testing the behavior of ToListElement
"
Class {
	#name : #ToListElementTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-List-Tests-Core'
}

{ #category : #tests }
ToListElementTest >> listWithRemoveRowButtons [

	| list |
	list := ToListElement new.
	space root addChild: list.
	list nodeBuilder: [ :node :dataItem :holder |
		| line remBut filler |
		line := ToPane horizontal id: #row.
		remBut := ToButton new id: #'remove-button-' , holder position asString.
		remBut withNullSkin.
		remBut icon: (ToImage inner: (self iconNamed: #windowClose)).
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

{ #category : #tests }
ToListElementTest >> testDataRemovedWhenNodeRemoved [

	| list but remButtons fillers |
	list := self listWithRemoveRowButtons.
	list dataAccessor addAll: (1 to: 2).
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	fillers := (list allChildrenBreadthFirstSelect: [ :child |
		               child id asString = 'filler' ])
		              asOrderedCollection.
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
		list primarySelectionMode selectionElementOption selectionElements isEmpty
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

{ #category : #tests }
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

{ #category : #tests }
ToListElementTest >> testNodeDeselectedWhenNodeRemoved [

	| list fillers remButtons but |
	list := self listWithRemoveRowButtons.
	list dataAccessor addAll: (1 to: 2).
	space applyAllSkinInstallers.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 2.
	remButtons := (list allChildrenBreadthFirstSelect: [ :child |
		               child id asString beginsWith: 'remove-button' ])
		              asOrderedCollection.
	fillers := (list selectChildrenWithId: #filler) asOrderedCollection.
	BlSpace simulateMouseDownOn: fillers first.
	BlSpace simulateMouseUpOn: fillers first.
	self assert: list dataAccessor size equals: 2.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert: list primarySelectionMode selectionElementOption selectionElements size
		equals: 1.
	but := remButtons at: 2.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert: list primarySelectionMode selectionElementOption selectionElements size
		equals: 1
]

{ #category : #tests }
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
		assert: list primarySelectionMode selectionElementOption selectionElements size
		equals: 1.
	but := list childWithId: #'remove-button-1'.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes isEmpty.
	self assert:
		list primarySelectionMode selectionElementOption selectionElements isEmpty
]

{ #category : #tests }
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
		assert: list primarySelectionMode selectionElementOption selectionElements size
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
		list primarySelectionMode selectionElementOption selectionElements isEmpty
]

{ #category : #tests }
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
		assert: list primarySelectionMode selectionElementOption selectionElements size
		equals: 1.
	but := list childWithId: #'remove-button-1'.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: list dataAccessor size equals: 0.
	self assert: list selectionModel selectedIndexes isEmpty.
	self assert:
		list primarySelectionMode selectionElementOption selectionElements isEmpty
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testRemoveAll [

	| l |
	l := ToListElement new.
	space root addChild: l.
	l innerContainer size: 800 @ 600.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self waitTestingSpaces.
	self assert: l innerContainer children size equals: 5.
	l selecter selectOnlyIndex: 2.
	self waitTestingSpaces.
	self assert: l selectionModel selectedIndexes equals: #( 2 ).
	l dataAccessor removeAll.
	self waitTestingSpaces.
	self assert: l innerContainer children size equals: 0.
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
	self assert: l innerContainer children size equals: 5.
	l dataAccessor addAllFirst: (self statesOfAmerica copyFrom: 6 to: 10).
	self assert: l dataAccessor size equals: 10.
	self assert: l innerContainer children size equals: 5.
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

	| l sp |
	l := ToListElement new.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	l forceLayout.
	l selecter selectOnlyIndex: 3.
	l dataAccessor removeAt: 2.
	sp := l inSpace.
	sp pulse.
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
	self assert: l selectionModel selectedIndexes equals: #(  )
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
