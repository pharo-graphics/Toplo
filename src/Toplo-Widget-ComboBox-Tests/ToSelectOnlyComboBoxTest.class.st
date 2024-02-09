"
A ToComboBoxTest is a test class for testing the behavior of ToComboBox
"
Class {
	#name : #ToSelectOnlyComboBoxTest,
	#superclass : #ToComboBoxTest,
	#category : #'Toplo-Widget-ComboBox-Tests'
}

{ #category : #asserting }
ToSelectOnlyComboBoxTest >> assertEmpty: aCombo [

	self assert: aCombo data notNil.
	self assert: aCombo data isEmpty.
	self assert: aCombo listFrame notNil.
	self assert: aCombo listElement notNil.
	self assert: aCombo headElement notNil.
	self assert: aCombo headElement first text isEmpty.
	self assert: aCombo listElement placeholder isNil.
	self assert: aCombo listElement data isEmpty.
	self assert: aCombo selectedIndex isZero.
	self assert: aCombo mode class equals: aCombo defaultMode class
]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testEmpty [

	| cb |
	self skip.
	cb := ToComboBox new.
	self assertEmpty: cb
]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testSelectDeselect [

	| cb  |
	self skip.
	cb := ToComboBox new.
	cb data addAll: self colors.
	cb selectIndex: 1.
	self assert: cb selectedIndex equals: 1.
	cb selectIndex: 0.
	self assert: cb selectedIndex equals: 0.

]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testSelectedIndexChange [

	| cb count index |
	self skip.
	cb := ToComboBox new.
	cb data addAll: self colors.
	count := 0.
	cb whenSelectedIndexChangedDo: [ :idx |
		count := count + 1.
		index := idx ].
	cb selectIndex: 1.
	self assert: count equals: 1.
	self assert: index equals: 1.
	cb selectIndex: 10.
	self assert: count equals: 2.
	self assert: index equals: 10
]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testWithColors [

	| cb |
	self skip.
	cb := ToComboBox new.
	cb data addAll: self colors.
	self assert: cb data size equals: self colors size.
	self assert: cb presentedData size equals: self colors size.
	cb selectIndex: 1.
	self assert: cb selectedIndex equals: 1.
	self assert: cb headElement first text asString equals: cb data first asString.
	cb selectIndex: 10.
	self assert: cb selectedIndex equals: 10.
	self assert: cb headElement first text asString equals: (cb data at: cb selectedIndex) asString.
	self assert: cb selectedData equals: (cb data at: cb selectedIndex)

	

]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testWithOneElement [

	| cb |
	self skip.
	cb := ToComboBox new.
	cb data add: 'one'.
	self assert: cb data size equals: 1.
	self assert: cb presentedData size equals: 1.
	self assert: cb selectedIndex isZero.
	cb forceLayout.
	self assert: cb listElement children size equals: 1.
	

]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testWithOneElement1 [

	| cb |
	self skip.
	cb := ToComboBox new.
	cb data add: 'one'.
	self assert: cb data size equals: 1.
	self assert: cb presentedData size equals: 1.
	cb selectIndex: 1.
	self assert: cb selectedIndex equals: 1.

	self assert: cb headElement first text asString equals: cb data first.
	

]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testWithStatesOfAmerica [

	| cb |
	self skip.
	cb := ToComboBox new.
	cb data addAll: self statesOfAmerica.
	self assert: cb data size equals: self statesOfAmerica size.
	self assert: cb presentedData size equals: self statesOfAmerica size.
	cb selectIndex: 1.
	self assert: cb selectedIndex equals: 1.
	self assert: cb headElement first text asString equals: cb data first.
	cb selectIndex: 10.
	self assert: cb selectedIndex equals: 10.
	self assert: cb headElement first text asString equals: (cb data at: cb selectedIndex).
	self assert: cb selectedData equals: (cb data at: cb selectedIndex)

	

]
