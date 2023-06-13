"
A ToComboBoxTest is a test class for testing the behavior of ToComboBox
"
Class {
	#name : #ToSelectOnlyComboBoxTest,
	#superclass : #ToComboBoxTest,
	#category : #'Toplo-Tests-Widget-ComboBox'
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
	self assert: aCombo selectedIndexInPresentedData isZero.
	self assert: aCombo mode class equals: aCombo defaultMode class
]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testEmpty [

	| cb |
	cb := ToComboBox new.
	self assertEmpty: cb
]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testSelectOnlyWithColors [

	| cb |
	cb := ToComboBox new.
	cb data addAll: self colors.
	self assert: cb data size equals: self colors size.
	self assert: cb presentedData size equals: self colors size.
	cb selectIndex: 1.
	self assert: cb selectedIndex equals: 1.
	self assert: cb selectedIndexInPresentedData equals: 1.
	self assert: cb headElement first text asString equals: cb data first asString.
	cb selectIndex: 10.
	self assert: cb selectedIndex equals: 10.
	self assert: cb selectedIndexInPresentedData equals: cb selectedIndex.
	self assert: cb headElement first text asString equals: (cb data at: cb selectedIndex) asString.
	self assert: cb selectedData equals: (cb data at: cb selectedIndex)

	

]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testSelectOnlyWithOneElement [

	| cb |
	cb := ToComboBox new.
	cb data add: 'one'.
	self assert: cb data size equals: 1.
	self assert: cb presentedData size equals: 1.
	self assert: cb selectedIndex isZero.
	self assert: cb selectedIndexInPresentedData isZero.
	cb forceLayout.
	self assert: cb listElement children size equals: 1.
	

]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testSelectOnlyWithOneElement1 [

	| cb |
	cb := ToComboBox new.
	cb data add: 'one'.
	self assert: cb data size equals: 1.
	self assert: cb presentedData size equals: 1.
	cb selectIndex: 1.
	self assert: cb selectedIndex equals: 1.
	self assert: cb selectedIndexInPresentedData equals: 1.

	self assert: cb headElement first text asString equals: cb data first.
	

]

{ #category : #tests }
ToSelectOnlyComboBoxTest >> testSelectOnlyWithStatesOfAmerica [

	| cb |
	cb := ToComboBox new.
	cb data addAll: self statesOfAmerica.
	self assert: cb data size equals: self statesOfAmerica size.
	self assert: cb presentedData size equals: self statesOfAmerica size.
	cb selectIndex: 1.
	self assert: cb selectedIndex equals: 1.
	self assert: cb selectedIndexInPresentedData equals: 1.
	self assert: cb headElement first text asString equals: cb data first.
	cb selectIndex: 10.
	self assert: cb selectedIndex equals: 10.
	self assert: cb selectedIndexInPresentedData equals: cb selectedIndex.
	self assert: cb headElement first text asString equals: (cb data at: cb selectedIndex).
	self assert: cb selectedData equals: (cb data at: cb selectedIndex)

	

]
