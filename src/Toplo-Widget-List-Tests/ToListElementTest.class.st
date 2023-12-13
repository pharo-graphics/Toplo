"
A ToListElementTest is a test class for testing the behavior of ToListElement
"
Class {
	#name : 'ToListElementTest',
	#superclass : 'ToInfiniteTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Widget-List-Tests-Core',
	#package : 'Toplo-Widget-List-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToListElementTest >> listWithRemoveRowButtons [

	|  list |
	list := ToListElement new.
	list nodeBuilder: [ :node :holder |
		| line remBut filler |
		line := ToPane horizontal id: #row.
		remBut := ToButton new id: #'remove-button'.
		remBut withoutSkin.
		remBut icon: (ToImage inner: (self iconNamed: #windowClose)).
		remBut constraintsDo: [ :c | c linear vertical alignCenter ].
		remBut
			when: BlClickEvent
			do: [ :event |
			event consumed: true.
			holder infiniteElement data removeAt: holder position ].
		filler := ToElement new matchParent; id: #filler.
		line addChild: filler.
		line addChild: remBut.
		node addChild: line ].
	^ list



]

{ #category : 'running' }
ToListElementTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'tests' }
ToListElementTest >> testDataCorrectlyRemovedWhenNodeRemoved [

	| list but remButtons |
	list := self listWithRemoveRowButtons.
	list data addAll: (1 to: 2).
	space root addChild: list.
	self waitTestingSpaces.
	self assert: list data size equals: 2.
	remButtons := (list selectChildrenWithId: #'remove-button')
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
ToListElementTest >> testSelectionCorrectlyRemovedWhenNodeRemoved [

	| list fillers |
	list := self listWithRemoveRowButtons.
	list data addAll: (1 to: 2).
	space root addChild: list.
	self waitTestingSpaces.
	self assert: list data size equals: 2.
	fillers := (list selectChildrenWithId: #filler)
		              asOrderedCollection.
	BlSpace simulateMouseDownOn: fillers first.
	BlSpace simulateMouseUpOn: fillers first.
	self assert: list data size equals: 2.
	self assert: list selectedIndexes equals: { 1 }
]
