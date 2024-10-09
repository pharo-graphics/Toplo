"
A ToCheckableGroupTest is a test class for testing the behavior of ToCheckableGroup
"
Class {
	#name : #ToCheckableGroupTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Button-Tests-Checkable'
}

{ #category : #tests }
ToCheckableGroupTest >> testBasic [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	self assert:
		(group checkingStrategy isKindOf: ToCheckableGroupStrictStrategy).
	self assert: group registeredCheckables size equals: 4.
	self assert: group checkedList size equals: 0.
	self
		assert: group uncheckedList size
		equals: group registeredCheckables size
]

{ #category : #tests }
ToCheckableGroupTest >> testCheck [

	| group checkBox checkBox2 |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		idx = 1 ifTrue: [ chb checked: true ].
		group register: chb ].

	checkBox := group registeredCheckables first.
	checkBox check.

	checkBox2 := group registeredCheckables at: 2.
	checkBox2 check.
	self deny: checkBox checked
]

{ #category : #tests }
ToCheckableGroupTest >> testCheck2 [

	| list modelButtonsGroup pane buttons |
	modelButtonsGroup := ToCheckableGroup new.
	list := OrderedCollection new.
	pane := ToPane vertical.
	list add: 'One'.
	list add: 'Two'.
	list add: 'Three'.
	buttons := list collect: [ :m |
		           ToRadioButton new
			           labelText: m;
			           hMatchParent;
			           id: m;
			           beStartToEnd ].
	modelButtonsGroup registerAll: buttons.
	self assert: modelButtonsGroup registeredCheckables size equals: 3.

	modelButtonsGroup checkingStrategy isKindOf:
		ToCheckableGroupStrictStrategy.

	buttons do: [ :b | pane addChild: b ].

	buttons first check.
	self assert: buttons first checked.
	self assert: buttons second checked not.
	self assert: buttons third checked not.
	buttons second check.
	self assert: buttons first checked not.
	self assert: buttons second checked.
	self assert: buttons third checked not.
	buttons third check.
	self assert: buttons first checked not.
	self assert: buttons second checked not.
	self assert: buttons third checked
]

{ #category : #tests }
ToCheckableGroupTest >> testIndeterminateRaiseError [

	| group btn |
	btn := ToCheckbox new.
	btn allowIndeterminate: true.
	group := ToCheckableGroup new.
	self should: [ group register: btn ] raise: Error
]

{ #category : #tests }
ToCheckableGroupTest >> testSwitchToNextState [

	| list modelButtonsGroup pane buttons |
	modelButtonsGroup := ToCheckableGroup new.
	list := OrderedCollection new.
	pane := ToPane vertical.
	list add: 'One'.
	list add: 'Two'.
	list add: 'Three'.
	buttons := list collect: [ :m |
		           ToRadioButton new
			           labelText: m;
			           hMatchParent;
			           id: m;
			           beStartToEnd ].
	modelButtonsGroup registerAll: buttons.
	self assert: modelButtonsGroup registeredCheckables size equals: 3.

	modelButtonsGroup checkingStrategy isKindOf:
		ToCheckableGroupStrictStrategy.

	buttons do: [ :b | pane addChild: b ].

	buttons first switchToNextCheckState.
	self assert: buttons first checked.
	self assert: buttons second checked not.
	self assert: buttons third checked not.
	buttons second switchToNextCheckState.
	self assert: buttons first checked not.
	self assert: buttons second checked.
	self assert: buttons third checked not.
	buttons third switchToNextCheckState.
	self assert: buttons first checked not.
	self assert: buttons second checked not.
	self assert: buttons third checked
]

{ #category : #tests }
ToCheckableGroupTest >> testUnregister [

	| group buttons |
	group := ToCheckableGroup new.
	buttons := (1 to: 4) collect: [ :idx | ToCheckbox new check ].
	group registerAll: buttons.
	self assert: group checkedList size equals: 1.
	self assert: group registeredCheckables first checked.
	group unregister: buttons second.
	self assert: group registeredCheckables size equals: 3.
	group unregister: buttons first.
	self assert: group registeredCheckables size equals: 2.
	self assert: group checkedList isEmpty
]

{ #category : #tests }
ToCheckableGroupTest >> testUpdateError [

	| group buttons |
	group := ToCheckableGroup new.
	buttons := (1 to: 4) collect: [ :idx | ToCheckbox new ].
	group registerAll: buttons.
	self
		should: [ group registeredCheckables at: 1 put: ToCheckbox new ]
		raise: Error
		description: 'Updating a button is not allowed'
]

{ #category : #tests }
ToCheckableGroupTest >> testWithOnePreChecked [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	group registeredCheckables second check.
	self assert: group checkedList size equals: 1.
	self assert: group registeredCheckables second checked.
	self
		assert: group uncheckedList size
		equals: group registeredCheckables size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testWithOnePreChecked2 [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	group registeredCheckables second checked: true.
	self assert: group checkedList size equals: 1.
	self assert: group registeredCheckables second isChecked.
	self assert: group registeredCheckables first isUnchecked.
	self assert: group registeredCheckables third isUnchecked.
	self assert: group registeredCheckables fourth isUnchecked.
	self
		assert: group uncheckedList size
		equals: group registeredCheckables size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testWithTwoPreChecked [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	group registeredCheckables second check.
	self assert: group checkedList size equals: 1.
	self assert: group registeredCheckables second checked.
	self
		assert: group uncheckedList size
		equals: group registeredCheckables size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testWithTwoPreChecked1 [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	group registeredCheckables second check.
	group registeredCheckables first check.
	self assert: group checkedList size equals: 1.
	self assert: group registeredCheckables first checked.
	self
		assert: group uncheckedList size
		equals: group registeredCheckables size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testWithTwoPreChecked2 [

	| group |
	group := ToCheckableGroup new.
	1 to: 2 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	group registeredCheckables second check.
	group registeredCheckables first check.
	3 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	self assert: group checkedList size equals: 1.
	self assert: group registeredCheckables first checked.
	self
		assert: group uncheckedList size
		equals: group registeredCheckables size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testWithTwoPreChecked3 [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		chb check.
		group register: chb ].
	self assert: group checkedList size equals: 1.
	self assert: group registeredCheckables fourth checked.
	self
		assert: group uncheckedList size
		equals: group registeredCheckables size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testWithTwoPreChecked4 [

	| group buttons |
	group := ToCheckableGroup new.
	buttons := (1 to: 4) collect: [ :idx | ToCheckbox new check ].
	group registerAll: buttons.
	self assert: group checkedList size equals: 1.
	self assert: group registeredCheckables first checked.
	self assert: group registeredCheckables second checked not.
	self assert: group registeredCheckables third checked not.
	self assert: group registeredCheckables fourth checked not
]
