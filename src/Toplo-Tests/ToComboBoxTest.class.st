"
A ToComboBoxTest is a test class for testing the behavior of ToComboBox
"
Class {
	#name : #ToComboBoxTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Widget-ComboBox'
}

{ #category : #asserting }
ToComboBoxTest >> assertEmpty: aCombo [

	self assert: aCombo data notNil.
	self assert: aCombo data isEmpty.
	self assert: aCombo listFrame notNil.
	self assert: aCombo listElement notNil.
	self assert: aCombo headElement notNil.
	self assert: aCombo listElement placeholder isNil.
	self assert: aCombo listElement data isEmpty.
	self assert: aCombo selectedIndex isZero.
	self assert: aCombo selectedIndexInPresentedData isZero.
	self assert: aCombo mode class equals: aCombo defaultMode class
]

{ #category : #tests }
ToComboBoxTest >> testEmpty [

	| cb |
	cb := ToComboBox new.
	self assertEmpty: cb
]
