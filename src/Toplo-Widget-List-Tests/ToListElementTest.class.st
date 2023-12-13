"
A ToListElementTest is a test class for testing the behavior of ToListElement
"
Class {
	#name : 'ToListElementTest',
	#superclass : 'ToInfiniteTest',
	#category : 'Toplo-Widget-List-Tests-Core',
	#package : 'Toplo-Widget-List-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToListElementTest >> testSelectionCorrectlyRemovedWhenNodeRemoved [

	| panel list |
	panel := ToPane vertical.
	panel constraints horizontal matchParent.
	panel layout cellSpacing: 10.

	list := ToList new.
	list nodeBuilder: [ :node :holder |
		| line remBut |
		line := ToPane horizontal.
		remBut := ToButton new.
		remBut withoutSkin.
		remBut icon: (ToImage inner: (self iconNamed: #windowClose)).
		remBut constraintsDo: [ :c | c linear vertical alignCenter ].
		remBut
			when: BlClickEvent
			do: [ :event |
			event consumed: true.
			holder infiniteElement data removeAt: holder position ].
		line addChild: remBut.
		
		node addChild: line ].
	list data addAll: (1 to: 2).
	panel addChild: list.

]
