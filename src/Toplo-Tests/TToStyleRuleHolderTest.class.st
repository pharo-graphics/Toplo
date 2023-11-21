"
A TToStyleRuleHolderTest is a test class for testing the behavior of TToStyleRuleHolder
"
Class {
	#name : 'TToStyleRuleHolderTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'tests' }
TToStyleRuleHolderTest >> testAddAllStyleRules [

	| e |
	e := ToStyleRuleHolderElementForTest new.
	e addAllStyleRules: {ToStyleRule new}.
	self assert: e styleRules size equals: 1.
	e addAllStyleRules: {ToStyleRule new. ToStyleRule new}.
	self assert: e styleRules size equals: 3.

]

{ #category : 'tests' }
TToStyleRuleHolderTest >> testAddStyleRule [

	| e |
	e := ToStyleRuleHolderElementForTest new.
	e addStyleRule: ToStyleRule new.
	self assert: e styleRules size equals: 1
]

{ #category : 'tests' }
TToStyleRuleHolderTest >> testStyleRules [

	| e |
	e := ToStyleRuleHolderElementForTest new.
	self assert: e styleRules size equals: 0.

]
