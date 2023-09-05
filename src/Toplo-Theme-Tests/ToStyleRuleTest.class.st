"
A ToStyleRuleTest is a test class for testing the behavior of ToStyleRule
"
Class {
	#name : #ToStyleRuleTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests'
}

{ #category : #tests }
ToStyleRuleTest >> testRuleWithNoSelector [
	" a rule with no selector accept nothing "
	| rule e |
	rule := ToStyleRule new.
	e := ToElement new.
	self assert: (rule canBeAppliedTo: e) not
]

{ #category : #tests }
ToStyleRuleTest >> testRuleWithUniversalSelector [
	" a rule with a unique univesal selector accept any element "

	| rule e |
	rule := ToStyleRule new
		        selectors: { ToUniversalSelector new }
		        looks: {  }.
	e := ToElement new.
	self assert: (rule canBeAppliedTo: e)
]

{ #category : #tests }
ToStyleRuleTest >> testRuleWithUniversalSelector2 [
	" a rule with a universal selector among others accept any element "

	| rule e |
	rule := ToStyleRule new
		        selectors: { ToIdSelector new id: #a. ToUniversalSelector new }
		        looks: {  }.
	e := ToElement new.
	self assert: (rule canBeAppliedTo: e)
]
