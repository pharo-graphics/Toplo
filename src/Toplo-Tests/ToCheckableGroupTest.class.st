"
A ToCheckableGroupTest is a test class for testing the behavior of ToCheckableGroup
"
Class {
	#name : #ToCheckableGroupTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Widget-Button'
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
	self assert: group uncheckedButtons size equals: group buttons size.
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
ToCheckableGroupTest >> testCheckableGroupWithOnePreCheckedButton [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx | 
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	group buttons second check.
	self assert: group checkedButtons size equals: 1.	
	self assert: group buttons second isChecked.
	self assert: group uncheckedButtons size equals: group buttons size - 1.
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithStartDefault [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx | 
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	group buttons second startChecked.
	self assert: group checkedButtons size equals: 1.	
	self assert: group buttons second isChecked.
	self assert: group uncheckedButtons size equals: group buttons size - 1.
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
	self assert: group buttons second isChecked.
	self assert: group uncheckedButtons size equals: group buttons size - 1.
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
	self assert: group buttons first isChecked.
	self assert: group uncheckedButtons size equals: group buttons size - 1.
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
	self assert: group buttons first isChecked.
	self assert: group uncheckedButtons size equals: group buttons size - 1.
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
	self assert: group buttons fourth isChecked.
	self assert: group uncheckedButtons size equals: group buttons size - 1.
]

{ #category : #tests }
ToCheckableGroupTest >> testCheckableGroupWithTwoPreCheckedButtons4 [

	| group buttons |
	group := ToCheckableGroup new.
	buttons := (1 to: 4) collect: [ :idx | ToCheckbox new check ].
	group addAll: buttons.
	self assert: group checkedButtons size equals: 1.	
	self assert: group buttons first isChecked.
	self assert: group buttons second isUnchecked.
	self assert: group buttons third isUnchecked.
	self assert: group buttons fourth isUnchecked
]

{ #category : #tests }
ToCheckableGroupTest >> testRemoveCheckableInCheckableGroup [

	| group buttons |
	group := ToCheckableGroup new.
	buttons := (1 to: 4) collect: [ :idx | ToCheckbox new check ].
	group addAll: buttons.
	self assert: group checkedButtons size equals: 1.	
	self assert: group buttons first isChecked.
	group remove: buttons second.
	self assert: group buttons size equals: 3.
	group remove: buttons first.
	self assert: group buttons size equals: 2.
	self assert: group checkedButtons isEmpty
]
