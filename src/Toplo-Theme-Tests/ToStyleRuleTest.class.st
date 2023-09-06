"
A ToStyleRuleTest is a test class for testing the behavior of ToStyleRule
"
Class {
	#name : #ToStyleRuleTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

{ #category : #tests }
ToStyleRuleTest >> testRuleWithChildSelector1 [
	" a rule with a universal selector among others accept any element "

	| rule parent child |
	rule := ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #child)
					  parent: (ToClassSelector new elementClass: #'direct-parent')
					  level: 1) }
			 looks: { }.
	child := ToElement new.
	child styleClass: #child.
	parent := ToElement new.
	parent styleClass: #'direct-parent'.
	parent addChild: child.
	self assert: (rule canBeAppliedTo: child)
]

{ #category : #tests }
ToStyleRuleTest >> testRuleWithChildSelector2 [
	" a rule with a universal selector among others accept any element "

	| rule child childchild |
	rule := ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #childchild) parent: (ToClassSelector new elementClass: #child) level: 1) }
			 looks: { }.
	childchild := ToElement new.
	childchild styleClass: #childchild.
	child := ToElement new.
	child styleClass: #child.
	self assert: (rule canBeAppliedTo: childchild) not.
	child addChild: childchild.
	self assert: (rule canBeAppliedTo: childchild)
]

{ #category : #tests }
ToStyleRuleTest >> testRuleWithChildSelector3 [
	" a rule with a universal selector among others accept any element "

	| rule parent child childchild |

	rule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 2) }
			 looks: { }.
	childchild := BlElement new.
	childchild styleClass: #childchild.
	child := BlElement new.
	child styleClass: #child.
	child addChild: childchild.
	parent := BlElement new.
	parent styleClass: #parent.
	parent addChild: child.
	self assert: childchild parent == child.
	self assert: child parent == parent.
	self assert: (rule canBeAppliedTo: childchild)
]

{ #category : #tests }
ToStyleRuleTest >> testRuleWithChildSelector4 [
	" a rule with a universal selector among others accept any element "

	| parent child childchild childchildchild childRule childchildRule childchildchildRule |

	childRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 1) }
			 looks: { }.
	childchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 2) }
			 looks: { }.
	childchildchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 3) }
			 looks: { }.
	childchildchild := BlElement new.
	childchildchild styleClass: #childchildchild.
	childchild := BlElement new.
	childchild styleClass: #childchild.
	child := BlElement new.
	child styleClass: #child.
	child addChild: childchild.
	childchild addChild: childchildchild.
	parent := BlElement new.
	parent styleClass: #parent.
	parent addChild: child.
	self assert: childchildchild parent == childchild.
	self assert: childchild parent == child.
	self assert: child parent == parent.
	self assert: (childRule canBeAppliedTo: child).
	self assert: (childchildRule canBeAppliedTo: childchild).
	self assert: (childchildchildRule canBeAppliedTo: childchildchild)
	
]

{ #category : #tests }
ToStyleRuleTest >> testRuleWithChildSelector5 [
	" a rule with a universal selector among others accept any element "

	| parent child childchild childchildchild childRule childchildRule childchildchildRule |

	childchildchild := BlElement new.
	childchildchild styleClass: #childchildchild.
	childchild := BlElement new.
	childchild styleClass: #childchild.
	child := BlElement new.
	child styleClass: #child.
	child addChild: childchild.
	childchild addChild: childchildchild.
	parent := BlElement new.
	parent styleClass: #parent.
	parent addChild: child.
	self assert: childchildchild parent == childchild.
	self assert: childchild parent == child.
	self assert: child parent == parent.
	
	childRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 0) }
			 looks: { }.
	childchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 1) }
			 looks: { }.
	childchildchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 2) }
			 looks: { }.
	
	self assert: (childRule canBeAppliedTo: child) not.
	self assert: (childchildRule canBeAppliedTo: childchild) not.
	self assert: (childchildchildRule canBeAppliedTo: childchildchild) not.
	
	childRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 2) }
			 looks: { }.
	childchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 3) }
			 looks: { }.
	childchildchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 4) }
			 looks: { }.
	
	self assert: (childRule canBeAppliedTo: child) not.
	self assert: (childchildRule canBeAppliedTo: childchild) not.
	self assert: (childchildchildRule canBeAppliedTo: childchildchild) not.

	childRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 1) }
			 looks: { }.
	childchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 2) }
			 looks: { }.
	childchildchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToClassSelector new elementClass: #parent) level: 3) }
			 looks: { }.
	
	self assert: (childRule canBeAppliedTo: child) .
	self assert: (childchildRule canBeAppliedTo: childchild) .
	self assert: (childchildchildRule canBeAppliedTo: childchildchild) 
		
]

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
