"
A ToCheckableGroupTest is a test class for testing the behavior of ToCheckableGroup
"
Class {
	#name : #ToCheckableGroupTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Button-Tests-Checkable'
}

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupBasic [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	self assert: (group checkingStrategy isKindOf: ToCheckableGroupStrictStrategy).
	self assert: group buttons size equals: 4.
	self assert: group checkedButtons size equals: 0.
	self assert: group uncheckedButtons size equals: group buttons size
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupUpdateError [

	| group buttons |
	group := ToCheckableGroup new.
	buttons := (1 to: 4) collect: [ :idx | ToCheckbox new ].
	group addAll: buttons.
	self
		should: [ group buttons at: 1 put: ToCheckbox new ]
		raise: Error
		description: 'Updating a button is not allowed'
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithDresserChangeAndCheckUse [

	| group checkBox checkBox2 |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx | | chb |
		chb := ToCheckbox new.
		idx = 1 ifTrue:[chb checked: true].
		group add: chb 
	].

	checkBox := group buttons first.
	checkBox check.
	
	checkBox2 := group buttons at: 2.
	checkBox2 check.
	self deny: checkBox checked.
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithDresserChangeAndCheckUse2 [

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
	modelButtonsGroup addAll: buttons.
	self assert: modelButtonsGroup buttons size equals: 3.

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
ToCheckableGroupTest >> testCheckableGroupWithDresserChangeAndSwitchToNextStateUse [

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
	modelButtonsGroup addAll: buttons.
	self assert: modelButtonsGroup buttons size equals: 3.

	modelButtonsGroup checkingStrategy isKindOf:
		ToCheckableGroupStrictStrategy.

	buttons do: [ :b | pane addChild: b ].

	buttons first switchToNextCheckStateOnClick.
	self assert: buttons first checked.
	self assert: buttons second checked not.
	self assert: buttons third checked not.
	buttons second switchToNextCheckStateOnClick.
	self assert: buttons first checked not.
	self assert: buttons second checked.
	self assert: buttons third checked not.
	buttons third switchToNextCheckStateOnClick.
	self assert: buttons first checked not.
	self assert: buttons second checked not.
	self assert: buttons third checked
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithIndeterminateRaiseError2 [

	| group btn |
	btn := ToCheckbox new.
	btn withIndeterminate: true.
	group := ToCheckableGroup new.
	self should: [ group add: btn ] raise: Error
	
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithOnePreCheckedButton [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	group buttons second check.
	self assert: group checkedButtons size equals: 1.
	self assert: group buttons second checked.
	self assert: group uncheckedButtons size equals: group buttons size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithStartDefault [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	group buttons second checked: true.
	self assert: group checkedButtons size equals: 1.
	self assert: group buttons second isChecked.
	self assert: group buttons first isUnchecked.
	self assert: group buttons third isUnchecked.
	self assert: group buttons fourth isUnchecked.
	self assert: group uncheckedButtons size equals: group buttons size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithTwoPreCheckedButtons0 [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	group buttons second check.
	self assert: group checkedButtons size equals: 1.
	self assert: group buttons second checked.
	self assert: group uncheckedButtons size equals: group buttons size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithTwoPreCheckedButtons1 [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	group buttons second check.
	group buttons first check.
	self assert: group checkedButtons size equals: 1.
	self assert: group buttons first checked.
	self assert: group uncheckedButtons size equals: group buttons size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithTwoPreCheckedButtons2 [

	| group |
	group := ToCheckableGroup new.
	1 to: 2 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	group buttons second check.
	group buttons first check.
	3 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	self assert: group checkedButtons size equals: 1.
	self assert: group buttons first checked.
	self assert: group uncheckedButtons size equals: group buttons size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithTwoPreCheckedButtons3 [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		chb check.
		group add: chb ].
	self assert: group checkedButtons size equals: 1.
	self assert: group buttons fourth checked.
	self assert: group uncheckedButtons size equals: group buttons size - 1
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithTwoPreCheckedButtons4 [

	| group buttons |
	group := ToCheckableGroup new.
	buttons := (1 to: 4) collect: [ :idx | ToCheckbox new check ].
	group addAll: buttons.
	self assert: group checkedButtons size equals: 1.
	self assert: group buttons first checked.
	self assert: group buttons second checked not.
	self assert: group buttons third checked not.
	self assert: group buttons fourth checked not
]

{ #category : #tests }
ToCheckableGroupTest >> testRemoveCheckableInCheckableGroup [

	| group buttons |
	group := ToCheckableGroup new.
	buttons := (1 to: 4) collect: [ :idx | ToCheckbox new check ].
	group addAll: buttons.
	self assert: group checkedButtons size equals: 1.
	self assert: group buttons first checked.
	group remove: buttons second.
	self assert: group buttons size equals: 3.
	group remove: buttons first.
	self assert: group buttons size equals: 2.
	self assert: group checkedButtons isEmpty
]
