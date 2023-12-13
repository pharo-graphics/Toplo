"
A ToListElementTest is a test class for testing the behavior of ToListElement
"
Class {
	#name : 'ToListTest',
	#superclass : 'ToInfiniteTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Widget-List-Tests-Core',
	#package : 'Toplo-Widget-List-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToListTest >> newList [

	^ ToList new
	
]

{ #category : 'running' }
ToListTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'tests' }
ToListTest >> testDataRemovedWhenNodeRemoved [

	| list but remButtons |
	list := self listWithRemoveRowButtons.
	list data addAll: (1 to: 2).
	space root addChild: list.
	self waitTestingSpaces.
	self assert: list data size equals: 2.
	remButtons := (list allChildrenBreadthFirstSelect: [:child | child id asString beginsWith: 'remove-button' ])
		              asOrderedCollection.
	but := remButtons removeFirst.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	but := remButtons removeFirst.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self assert: list data isEmpty
]

{ #category : 'tests' }
ToListTest >> testNodeDeselectedWhenNodeRemoved [

	| list fillers remButtons but |
	list := self listWithRemoveRowButtons.
	list data addAll: (1 to: 2).
	space root addChild: list.
	self waitTestingSpaces.
	self assert: list data size equals: 2.
	remButtons := (list allChildrenBreadthFirstSelect: [:child | child id asString beginsWith: 'remove-button' ])
		              asOrderedCollection.
	fillers := (list selectChildrenWithId: #filler)
		              asOrderedCollection.
	BlSpace simulateMouseDownOn: fillers first.
	BlSpace simulateMouseUpOn: fillers first.
	self assert: list data size equals: 2.
	self assert: list selectedIndexes equals: { 1 }.
	but := remButtons at: 2.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self assert: list data size equals: 1.
	self assert: list selectedIndexes equals: { 1 }.

]

{ #category : 'tests' }
ToListTest >> testNodeDeselectedWhenNodeRemoved2 [

	| list fillers  but |
	list := self listWithRemoveRowButtons.
	list data addAll: (1 to: 2).
	space root addChild: list.
	space root forceLayout.
	self waitTestingSpaces.
	self assert: list data size equals: 2.
	fillers := (list selectChildrenWithId: #filler)
		              asOrderedCollection.
	BlSpace simulateMouseDownOn: fillers first.
	BlSpace simulateMouseUpOn: fillers first.
	self waitTestingSpaces.
	self assert: list data size equals: 2.
	self assert: list selectedIndexes equals: { 1 }.
	but := list childWithId: #'remove-button-1'.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: list data size equals: 1.
	self assert: list selectedIndexes isEmpty

]
