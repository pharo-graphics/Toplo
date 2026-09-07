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
	space deferAndSettle: [ space root addChild: list ].
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
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testCheckboxSelectionUpdatedAfterInsert [

	| l |
	l := ToListElement new.
	l useCheckbox: true.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	"Needs to be in a separate block to let layout build node containers before selection"
	space deferAndSettle: [
		l selecter selectOnlyIndex: 3 ].
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	self assert: (l nodeContainers third) checkbox isChecked.

	space deferAndSettle: [ l dataAccessor add: (self statesOfAmerica at: 6) afterIndex: 1  ].
	self assert: l selectionModel selectedIndexes equals: { 4 }.
	self deny: (l nodeContainers third) checkbox isChecked.
	self assert: (l nodeContainers fourth) checkbox isChecked
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testCheckboxSelectionUpdatedAfterInsert1 [

	| l |
	l := ToListElement new.
	l matchParent.
	l useCheckbox: true.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l dataAccessor size equals: 5.

	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	self assert: l nodeContainers third checkbox isChecked.
	self assert: l nodeContainers size equals: 5.

	space deferAndSettle: [ l dataAccessor addAllFirst: (self statesOfAmerica copyFrom: 6 to: 10) ].
	self assert: l dataAccessor size equals: 10.
	self assert: (l selectionModel selectedIndexes) equals: { 8 }.
	self deny: (l nodeContainers third) checkbox isChecked.
	self assert: (l nodeContainers at: 8) checkbox isChecked
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testCheckboxSelectionUpdatedAfterInsert2 [

	| l |
	l := ToListElement new.
	l matchParent.
	l useCheckbox: true.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l dataAccessor size equals: 5.

	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	self assert: l nodeContainers third checkbox isChecked.
	self assert: l nodeContainers size equals: 5.

	space deferAndSettle: [ l dataAccessor addAllFirst: (self statesOfAmerica copyFrom: 6 to: 6)  ].
	self assert: l dataAccessor size equals: 6.
	self assert: (l selectionModel selectedIndexes) equals: { 4 }.
	self deny: (l nodeContainers third) checkbox isChecked.
	self assert: (l nodeContainers fourth) checkbox isChecked
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testCheckboxSelectionUpdatedAfterInsert3 [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		space root addChild: l.
		l matchParent.
		l useCheckbox: true.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l selectionModel isEmpty.

	space deferAndSettle: [ l selecter selectIndexes: #( 3 4 ) ].
	self assert: l selectionModel selectedIndexes equals: #( 3 4 ).
	self assert: (l nodeContainers third) checkbox isChecked.
	self assert: (l nodeContainers fourth) checkbox isChecked.

	space deferAndSettle: [ l dataAccessor add: (self statesOfAmerica at: 6) afterIndex: 1 ].
	self assert: l selectionModel selectedIndexes equals: #( 4 5 ).
	self deny: (l nodeContainers third) checkbox isChecked.
	self assert: (l nodeContainers fourth) checkbox isChecked.
	self assert: (l nodeContainers fifth) checkbox isChecked
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testCheckboxSelectionUpdatedAfterInsert4 [

	| l |
	l := ToListElement new.
	l useCheckbox: true.
	space deferAndSettle: [
		space root addChild: l.
		l matchParent.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 1) ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ l selecter selectIndex: 1 ].
	self assert: l selectionModel selectedIndexes equals: { 1 }.
	self assert: (l nodeContainers first) checkbox isChecked.

	space deferAndSettle: [ l dataAccessor addFirst: (self statesOfAmerica at: 6) ].
	self assert: l selectionModel selectedIndexes equals: { 2 }.
	self deny: (l nodeContainers first) checkbox isChecked.
	self assert: (l nodeContainers second) checkbox isChecked
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testCheckboxSelectionUpdatedAfterRemove [

	| l selectionElement |
	l := ToListElement new.
	l useCheckbox: true.
	l matchParent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	self assert: (l nodeContainers third) checkbox isChecked.

	space deferAndSettle: [ l dataAccessor removeAt: 2 ].
	self assert: l selectionModel selectedIndexes equals: { 2 }.
	self assert: (l nodeContainers second) checkbox isChecked.
	self deny: (l nodeContainers third) checkbox isChecked.
	self assert: l selectionOption selectionContainer children size equals: 1.
	selectionElement := l selectionOption selectionContainer firstChild.
	self assert: selectionElement bounds asRectangle equals: (selectionElement boundsInListElement: l)
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testCheckboxSelectionUpdatedAfterRemove2 [

	| l selectionElement |
	l := ToWrappedListElement new.
	l useCheckbox: true.
	l matchParent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	self assert: (l nodeContainers third) checkbox isChecked.

	space deferAndSettle: [ l dataAccessor removeAt: 2 ].
	self assert: l selectionModel selectedIndexes equals: { 2 }.
	self assert: (l nodeContainers second) checkbox isChecked.
	self deny: (l nodeContainers third) checkbox isChecked.
	self assert: l selectionOption selectionContainer children size equals: 1.
	selectionElement := l selectionOption selectionContainer firstChild.
	self assert: selectionElement bounds asRectangle equals: (selectionElement boundsInListElement: l)
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testDataRemovedWhenNodeRemoved [

	| list but remButtons fillers |
	list := self listWithRemoveRowButtons.
	space deferAndSettle: [ list dataAccessor addAll: (1 to: 2)  ].
	self assert: list dataAccessor size equals: 2.
	self assert: list nodeContainers size equals: 2.

	fillers := (list innerElement
		allChildrenBreadthFirstSelect: [ :child |
			child id asString = 'filler' ]) asOrderedCollection.
	remButtons := (list innerElement
		allChildrenBreadthFirstSelect: [ :child |
			child id asString beginsWith: 'remove-button' ]) asOrderedCollection.
	" first click on the list to set the focus "
	fillers first eventSimulator click.
	but := remButtons removeFirst.
	but eventSimulator click.
	but := remButtons removeFirst.
	but eventSimulator click.
	self assert: list dataAccessor isEmpty.
	self assert:
		list primarySelectionMode selectionOption selectionElements isEmpty
]

{ #category : #'test selection - mode' }
ToListElementTest >> testDisable [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		space root addChild: l.
		l matchParent.
		l dataAccessor addAll: { #A. #B. #C } ].
	space deferAndSettle: [
		l selecter selectOneMoreIndex: 2.
		l secondarySelecter selectOneMoreIndex: 3 ].
	self assert: l selectionModel selectedIndexes equals: { 2 }.
	self assert: l secondarySelectionModel selectedIndexes equals: { 3 }.

	space deferAndSettle: [ l disable ].
	self assert: l isDisabled.
	self assert: l selectionModel isEmpty.
	self assert: l secondarySelectionModel isEmpty.
	l nodeContainersDo: [ :container | self assert: container isDisabled ]
]

{ #category : #'test selection - mode' }
ToListElementTest >> testDisabledSelectionModel [

	| l |
	l := ToListElement new.
	self assert:
		(l disabledSelectionMode selectionModel isKindOf: ToSubSelectionModel).
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
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: { #A. #B. #C } ].
	"Must be in a separate block to let layout build node containers before selection"
	space deferAndSettle: [
		l selecter selectOneMoreIndex: 2 ].
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
	space deferAndSettle: [
		l dataAccessor add: 'first' .
		space root addChild: l ].
	self assert: l nodeContainers size equals: 1.

	space deferAndSettle: [
		l innerElement nodeContainers first holder disabled: true ].
	space deferAndSettle: [
		l dataAccessor addFirst: 'second' .
		l dataAccessor add: 'third' .
		l dataAccessor add: 'fourth' afterIndex: 2 .
		l dataAccessor addFirst: 'fifth' ].
	self assert: l disabledSelecter selectedIndexes equals: { 3 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithFourNodes [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		l dataAccessor add: 'first' .
		space root addChild: l ].
	self assert: l nodeContainers size equals: 1.

	space deferAndSettle: [
		l nodeContainers first disabled: true ].
	space deferAndSettle: [
		l dataAccessor addFirst: 'second' .
		l dataAccessor add: 'third' .
		l dataAccessor add: 'fourth' afterIndex: 2 ].
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithFourNodes2 [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		space root addChild: l .
		l dataAccessor add: 'first' .
		l dataAccessor add: 'second' ].

	space deferAndSettle: [
		l nodeContainers second disabled: true ].
	space deferAndSettle: [
		l dataAccessor add: 'third' .
		l dataAccessor add: 'fourth' ].
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithOneNode [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		space root addChild: l .
		l dataAccessor add: 'first' ].
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.

	space deferAndSettle: [ l disabledSelecter selectOneMoreIndex: 1 ].
	self assert: l disabledSelecter selectedIndex equals: 1
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithThreeNodes [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		l dataAccessor add: 'first' .
		space root addChild: l ].
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	
	space deferAndSettle: [
		l nodeContainers first holder disabled: true ].
	self assert: l disabledSelecter selectedIndex equals: 1.

	space deferAndSettle: [ l dataAccessor addFirst: 'second' ].
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.

	space deferAndSettle: [ l dataAccessor add: 'third' ].
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithTwoNodes [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		l dataAccessor add: 'first'.
		space root addChild: l ].
	self assert: l innerElement children size equals: 1.
	self assert: l disabledSelectionModel isEmpty.

	space deferAndSettle: [
		l disabledSelecter selectOneMoreIndex: 1 ].
	self assert: l disabledSelecter selectedIndex equals: 1.

	space deferAndSettle: [ l dataAccessor addFirst: 'second' ].
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithTwoNodes2 [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		l dataAccessor add: 'first' .
		space root addChild: l ].
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	
	space deferAndSettle: [
		l nodeContainers first disabled: true ].
	self assert: l disabledSelecter selectedIndex equals: 1.

	space deferAndSettle: [ l dataAccessor addFirst: 'second'  ].
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test node - enablement' }
ToListElementTest >> testDisabledWithTwoNodes3 [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		l dataAccessor add: 'first' .
		space root addChild: l ].
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.

	space deferAndSettle: [
		l nodeContainers first disabled: true ].
	self assert: l disabledSelecter selectedIndex equals: 1.
	self assert: l nodeContainers first node isDisabled.

	space deferAndSettle: [ l dataAccessor addFirst: 'second'  ].
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #'test selection - event' }
ToListElementTest >> testDoubleListsSelectionEvents [

	| panel list1 list2 tabSize |
	panel := ToPane new.
	panel matchParent.
	tabSize := 2.
	list1 := ToListElement new.
	list2 := ToListElement new.
	space deferAndSettle: [
		space root addChild: panel.
		panel addChild: list1 .
		panel addChild: list2 ].
	space deferAndSettle: [ 
		1 to: tabSize do: [ :i |
			list1 dataAccessor add: 'Hello ' , i asString ] ].
	self assert: list1 nodeContainers size equals: tabSize.

	space deferAndSettle: [ 
		1 to: tabSize do: [ :i |
			list2 dataAccessor add: 'Goodbye ' , i asString ] ].
		list1 addEventHandler: (BlEventHandler
			on: ToListPrimarySelectionChangedEvent
			do: [ :e |
					list2 selecter deselectAll.
					e currentTarget selectionModel selectedIndexesDo: [ :idx |
						list2 selecter selectOneMoreIndex: idx ].
					]).
	space deferAndSettle: [ list1 selecter selectOneMoreIndex: 1 ].
	self assert: (list1 selectionModel containsIndex: 1).
	self assert: (list2 selectionModel containsIndex: 1).

	space deferAndSettle: [ list2 selecter selectIndex: 2 ].
	self assert: (list2 selectionModel containsIndex: 2)
]

{ #category : #tests }
ToListElementTest >> testEmptyList [

	| l |
	l := ToListElement new.
	l fitContent.
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
	self assert: l selectionModel isEmpty.

	space deferAndSettle: [
		l selecter selectOneMoreIndex: l selecter nextSelectableIndex ].
	self assert: l selecter currentIndex isZero
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testEmptyListAddOrRemovePreviousInSelection [

	| l |
	l := ToListElement new.
	l fitContent.
	self assert: l dataAccessor isEmpty.
	self assert: l selectionModel isEmpty.

	space deferAndSettle: [
		l selecter selectOneMoreIndex: l selecter previousSelectableIndex ].
	space deferAndSettle: [
		l selecter scrollToDataSourcePosition: l selecter currentIndex ].
	self assert: l selecter currentIndex isZero
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testEmptyListSelectNextInSelection [

	| l |
	l := ToListElement new.
	l fitContent.
	self assert: l dataAccessor isEmpty.
	self assert: l selectionModel isEmpty.

	space deferAndSettle: [ l selecter selectOneMoreIndex: l selecter nextSelectableIndex ].
	self assert: l selecter currentIndex isZero.
	self assert: l selectionModel isEmpty.

	space deferAndSettle: [ l selecter selectOneMoreIndex: l selecter nextSelectableIndex ].
	self assert: l selecter currentIndex isZero.
	self assert: l selectionModel isEmpty
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testEmptyListSelectPreviousInSelection [

	| l |
	l := ToListElement new.
	l fitContent.
	self assert: l dataAccessor isEmpty.

	space deferAndSettle: [
		l selecter selectOneMoreIndex: l selecter previousSelectableIndex .
		l selecter selectOneMoreIndex: l selecter previousSelectableIndex.
		l selecter scrollToDataSourcePosition: l selecter currentIndex ].
	self assert: l selecter currentIndex isZero.
	self assert: l selectionModel isEmpty
]

{ #category : #'test selection - mode' }
ToListElementTest >> testEnable [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		l matchParent.
		l dataAccessor addAll: { #A. #B. #C } .
		l selecter selectOneMoreIndex: 2 .
		l secondarySelecter selectOneMoreIndex: 3 .
		l disable.
		space root addChild: l ].
	self assert: l isDisabled.
	self assert: l selectionModel isEmpty.
	self assert: l secondarySelectionModel isEmpty.

	l nodeContainersDo: [ :container | self assert: container isDisabled ].

	space deferAndSettle: [ l enable ].
	self assert: l isEnabled.
	self assert: l selectionModel isEmpty.
	self assert: l secondarySelectionModel isEmpty.
	l nodeContainersDo: [ :container | self deny: container isDisabled ]
]

{ #category : #'test selection - mode' }
ToListElementTest >> testHiddenSelectionModel [

	| l |
	l := ToListElement new.
	self assert: (l hiddenSelectionMode selectionModel isKindOf: ToSubSelectionModel).
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
	space deferAndSettle: [ l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l dataAccessor size equals: 5
]

{ #category : #'test node - enablement' }
ToListElementTest >> testMakeDisabledUnselectable [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		space root addChild: l.
		l selectionMode makeDisabledUnselectable: true .
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	space deferAndSettle: [
		l disabledSelecter selectOneMoreIndex: 3 ].
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	self assert: l unselectableSelecter selectedIndexes equals: {  }.

	space deferAndSettle: [ l selecter selectOneMoreIndex: 3 ].
	self assert: l selecter selectedIndexes equals: {  }.

	space deferAndSettle: [
		l selectionMode makeDisabledUnselectable: false .
		l selecter selectIndex: 3 ].
	self assert: l selecter selectedIndexes equals: { 3 }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testNodeDeselectedWhenNodeRemoved [

	| list fillers remButtons but |
	list := self listWithRemoveRowButtons.
	space deferAndSettle: [ list dataAccessor addAll: (1 to: 2) ].
	self assert: list dataAccessor size equals: 2.

	remButtons := (list innerElement allChildrenBreadthFirstSelect: [ :child |
		               child id asString beginsWith: 'remove-button' ])
		              asOrderedCollection.
	fillers := (list selectChildrenWithId: #filler) asOrderedCollection.
	fillers first eventSimulator mouseDown.
	fillers first eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 2.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert: list primarySelectionMode selectionOption selectionElements size
		equals: 1.

	but := remButtons second.
	but eventSimulator mouseDown.
	but eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert: list primarySelectionMode selectionOption selectionElements size
		equals: 1
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testNodeDeselectedWhenNodeRemoved2 [

	| list fillers but |
	list := self listWithRemoveRowButtons.
	space deferAndSettle: [ list dataAccessor addAll: (1 to: 2) ].
	self assert: list dataAccessor size equals: 2.

	fillers := (list selectChildrenWithId: #filler) asOrderedCollection.
	fillers first eventSimulator mouseDown.
	fillers first eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 2.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert: list primarySelectionMode selectionOption selectionElements size
		equals: 1.

	but := list childWithId: #'remove-button-1'.
	but eventSimulator mouseDown.
	but eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes isEmpty.
	self assert:
		list primarySelectionMode selectionOption selectionElements isEmpty
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testNodeDeselectedWhenNodeRemoved3 [

	| list fillers but |
	list := self listWithRemoveRowButtons.
	space deferAndSettle: [ list dataAccessor addAll: (1 to: 2) ].
	self assert: list dataAccessor size equals: 2.

	fillers := (list selectChildrenWithId: #filler) asOrderedCollection.
	fillers first eventSimulator mouseDown.
	fillers first eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 2.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert: list primarySelectionMode selectionOption selectionElements size
		equals: 1.

	but := list childWithId: #'remove-button-1'.
	but eventSimulator mouseDown.
	but eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes isEmpty.

	but := list childWithId: #'remove-button-2'.
	but eventSimulator mouseDown.
	but eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 0.
	self assert: list selectionModel selectedIndexes isEmpty.
	self assert:
		list primarySelectionMode selectionOption selectionElements isEmpty
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testNodeDeselectedWhenNodeRemoved4 [

	| list fillers but |
	list := self listWithRemoveRowButtons.
	space deferAndSettle: [ list dataAccessor addAll: (1 to: 2) ].
	self assert: list dataAccessor size equals: 2.

	fillers := (list selectChildrenWithId: #filler) asOrderedCollection.
	fillers first eventSimulator mouseDown.
	fillers first eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 2.
	self assert: list selectionModel selectedIndexes equals: { 1 }.

	but := list childWithId: #'remove-button-2'.
	but eventSimulator mouseDown.
	but eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes equals: { 1 }.
	self
		assert: list primarySelectionMode selectionOption selectionElements size
		equals: 1.

	but := list childWithId: #'remove-button-1'.
	but eventSimulator mouseDown.
	but eventSimulator mouseUp.
	self assert: list dataAccessor size equals: 0.
	self assert: list selectionModel selectedIndexes isEmpty.
	self assert:
		list primarySelectionMode selectionOption selectionElements isEmpty
]

{ #category : #'test - selection changed event' }
ToListElementTest >> testPrimarySelectionChangedEventDispatch [
	" event dispateched when a selected node is removed "

	| l dispatchedEvent |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	self
		assert: l selectionMode selectionContainer children size
		equals: 1.
	l
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | dispatchedEvent := event ].
	dispatchedEvent := nil.
	"Must be in a separate block to let layout/event loop process selection before removal"
	space deferAndSettle: [ l dataAccessor removeAt: 3 ].
	self assert: l selectionModel selectedIndexes equals: {  }.
	self assert: l selectionMode selectionContainer children isEmpty.
	self assert: dispatchedEvent notNil
]

{ #category : #'test - selection changed event' }
ToListElementTest >> testPrimarySelectionChangedEventDispatch1 [
	" event dispateched when a selected node is removed "

	| l dispatchedEvent |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	l
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | dispatchedEvent := event ].
	dispatchedEvent := nil.
	"Must be in a separate block to let layout/event loop process selection before removal"
	space deferAndSettle: [ l dataAccessor removeAt: 3 ].
	self assert: l selectionModel selectedIndexes equals: {  }.
	self assert: l selectionMode selectionContainer children isEmpty.
	self assert: dispatchedEvent notNil
]

{ #category : #'test - selection changed event' }
ToListElementTest >> testPrimarySelectionChangedEventDispatchAfterRemoveAll [
	" event dispateched when a selected node is removed "

	| l dispatchedEvent |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	self
		assert: l selectionMode selectionContainer children size
		equals: 1.
	l
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | dispatchedEvent := event ].
	dispatchedEvent := nil.
	self assert: l selectionModel selectedIndexes equals: { 3 }.

	space deferAndSettle: [ l dataAccessor removeAll ].
	self assert: l selectionModel selectedIndexes equals: {  }.
	self assert: l selectionMode selectionContainer children isEmpty.
	self assert: dispatchedEvent notNil
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testRemoveAll [

	| l |
	l := ToListElement new.
	l innerElement extent: 800 @ 600.
	l fitContent.
	l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	space deferAndSettle: [ space root addChild: l ].
	self assert: l nodeContainers size equals: 5.

	space deferAndSettle: [ l selecter selectOnlyIndex: 2 ].
	self assert: l selectionModel selectedIndexes equals: #( 2 ).

	space deferAndSettle: [ l dataAccessor removeAll ].
	self assert: l nodeContainers size equals: 0.
	self assert: l selectionModel selectedIndexes isEmpty
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testSelectAndScrollToNext [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		space root addChild: l.
		l fitContent.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l dataAccessor size equals: 5.

	space deferAndSettle: [
		l selecter selectOneMoreIndex: 4 .
		l selecter selectOneMoreIndex: 2 ].
	self assert: l selecter currentIndex equals: 2.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 2 4 ).

	space deferAndSettle: [ l selecter selectIndex: l selecter nextSelectableIndex ].
	space deferAndSettle: [ l selecter scrollToDataSourcePosition: l selecter currentIndex ].
	self assert: l selecter currentIndex equals: 3.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 2 3 4 ).

	space deferAndSettle: [ l selecter selectIndex: l selecter nextSelectableIndex ].
	space deferAndSettle: [ l selecter scrollToDataSourcePosition: l selecter currentIndex ].
	self assert: l selecter currentIndex equals: 4.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 2 3 4 )
]

{ #category : #'test selection - select next/previous' }
ToListElementTest >> testSelectAndScrollToPrevious [

	| l |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5)  ].
	self assert: l dataAccessor size equals: 5.

	space deferAndSettle: [ l selecter selectOneMoreIndex: 4 ].
	self assert: l selecter currentIndex equals: 4.
	self assert: l selectionModel selectedIndexes asArray equals: #( 4 ).

	space deferAndSettle: [ l selecter selectOneMoreIndex: l selecter previousSelectableIndex ].
	space deferAndSettle: [ l selecter scrollToDataSourcePosition: l selecter currentIndex ].
	self assert: l selecter currentIndex equals: 3.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 3 4 ).

	space deferAndSettle: [ l selecter selectIndex: l selecter previousSelectableIndex ].
	space deferAndSettle: [ l selecter scrollToDataSourcePosition: l selecter currentIndex ].
	self assert: l selecter currentIndex equals: 2.
	self
		assert: l selectionModel selectedIndexes asArray
		equals: #( 2 3 4 )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionAfterLastRemoval [

	| l |
	l := ToListElement new.
	l secondarySelectionMode selecter enabled: false.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l selectionModel selectedIndexes isEmpty.

	space deferAndSettle: [ l selecter selectIndexes: #( 5 ) ].
	self assert: l selectionModel selectedIndexes equals: #( 5 ).

	space deferAndSettle: [ l dataAccessor removeAt: 5 ].
	self assert: l selectionModel selectedIndexes equals: #(  )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterInsert [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [
		l selecter selectOnlyIndex: 3 ].
	self assert: l selecter currentIndex equals: 3.

	space deferAndSettle: [ l dataAccessor add: (self statesOfAmerica at: 6) afterIndex: 1 ].
	self assert: l selecter currentIndex equals: 3.
	self assert: l selectionModel lastIndex equals: 4
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterInsert1 [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l dataAccessor size equals: 5.

	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	self assert: l selectionModel selectedIndexes equals: { 3 }.
	self assert: l selecter currentIndex equals: 3.
	self assert: l nodeContainers size equals: 5.

	space deferAndSettle: [ l dataAccessor addAllFirst: (self statesOfAmerica copyFrom: 6 to: 10) ].
	self assert: l dataAccessor size equals: 10.
	self assert: l nodeContainers size equals: 10.
	self assert: l selectionModel lastIndex equals: 8
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterInsert3 [

	| l |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l selectionModel isEmpty.

	space deferAndSettle: [ l selecter selectIndexes: #( 3 4 ) ].
	self assert: l selectionModel selectedIndexes equals: #( 3 4 ).
	self assert: l selecter currentIndex equals: 4.

	space deferAndSettle: [ l dataAccessor add: (self statesOfAmerica copyFrom: 6 to: 6) afterIndex: 1 ].
	self assert: l selecter currentIndex equals: 4.
	self assert: l selecter currentIndex equals: 4.
	self assert: l selectionModel selectedIndexes equals: #( 4 5 )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove [

	| l |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	"Must be in a separate block to let layout/event loop process selection before removal"
	space deferAndSettle: [ l dataAccessor removeAt: 2 ].
	self assert: l selectionModel selectedIndexes equals: { 2 }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove1 [

	| l |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	"Must be in a separate block to let layout process item addition before selection"
	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	self assert: l selectionModel selectedIndexes equals: { 3 }.

	space deferAndSettle: [ l dataAccessor removeAll ].
	self assert: l dataAccessor size equals: 0.
	self assert: l selectionModel isEmpty
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove2 [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l dataAccessor size equals: 5.
	self assert: l selectionModel isEmpty.

	space deferAndSettle: [ l selecter selectOnlyIndex: 3 ].
	self assert: l selecter currentIndex equals: 3.

	space deferAndSettle: [ l dataAccessor removeAt: 4 ].
	self assert: l selectionModel selectedIndexes equals: { 3 }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove3 [

	| l |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l selectionModel selectedIndexes isEmpty.

	space deferAndSettle: [ l selecter selectIndexes: #( 3 4 ) ].
	self assert: l selectionModel selectedIndexes equals: #( 3 4 ).

	space deferAndSettle: [ l dataAccessor removeAt: 2 ].
	self assert: l selectionModel selectedIndexes equals: #( 2 3 )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove4 [

	| l |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l dataAccessor size equals: 5.
	self assert: l selectionModel selectedIndexes isEmpty.

	space deferAndSettle: [ l selecter selectIndexes: #( 2 ) ].
	self assert: l selectionModel selectedIndexes equals: #( 2 ).

	space deferAndSettle: [ l dataAccessor removeAt: 2 ].
	self assert: l selectionModel selectedIndexes equals: {  }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove5 [

	| l |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l selectionModel selectedIndexes isEmpty.

	space deferAndSettle: [ l selecter selectIndexes: #( 3 4 ) ].
	self assert: l selectionModel selectedIndexes equals: #( 3 4 ).

	space deferAndSettle: [ l dataAccessor removeAt: 3 ].
	self assert: l selectionModel selectedIndexes equals: #( 3 )
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionUpdatedAfterRemove6 [

	| l |
	l := ToListElement new.
	l fitContent.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: (self statesOfAmerica copyFrom: 1 to: 5) ].
	self assert: l selectionModel selectedIndexes isEmpty.

	space deferAndSettle: [ l selecter selectIndexes: #( 3 4 ) ].
	self assert: l selectionModel selectedIndexes equals: #( 3 4 ).

	space deferAndSettle: [
		l dataAccessor removeAt: 3.
		l dataAccessor removeAt: 3 ].
	self assert: l selectionModel selectedIndexes equals: {  }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionWithOneNode [

	| l |
	l := ToListElement new.
	l dataAccessor removeAll.
	space deferAndSettle: [
		l dataAccessor add: 'first' .
		space root addChild: l ].
	self assert: l innerElement children size equals: 1.
	self assert: l selectionModel isEmpty.

	space deferAndSettle: [ l selecter selectOneMoreIndex: 1 ].
	self assert: l selecter selectedIndex equals: 1.
	self assert: l selectionModel selectedIndexes equals: { 1 }
]

{ #category : #'test selection - adding/removing' }
ToListElementTest >> testSelectionWithTwoNodes [

	| l |
	l := ToListElement new.
	space deferAndSettle: [
		l dataAccessor add: 'first' .
		space root addChild: l ].
	self assert: l innerElement children size equals: 1.
	self assert: l selectionModel isEmpty.

	space deferAndSettle: [ l selecter selectOneMoreIndex: 1 ].
	self assert: l selecter selectedIndex equals: 1.

	space deferAndSettle: [ l dataAccessor addFirst: 'second'  ].
	self assert: l selecter selectedIndex equals: 2.
	self assert: l selecter selectedIndexes equals: { 2 }
]

{ #category : #'test selection - mode' }
ToListElementTest >> testUnselectableSelectionModel [

	| l |
	l := ToListElement new.
	self assert: (l unselectableSelectionMode selectionModel isKindOf: ToSubSelectionModel).
	self
		assert: l unselectableSelectionMode selectionModel
		identicalTo: l unselectableSelecter selectionModel.
	self
		assert: l unselectableSelectionModel
		identicalTo: l unselectableSelecter selectionModel
]
