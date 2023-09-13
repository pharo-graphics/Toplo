"
A ToStyleRuleTest is a test class for testing the behavior of ToStyleRule
"
Class {
	#name : #ToStyleRuleTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

{ #category : #tests }
ToStyleRuleTest >> testRuleWithAndSelector [
	" a rule with an And operator  "
	| rule e |
	rule := ToStyleRule new
			 selectors: { 
				(ToStyleClassSelector new styleClasses: #( #button )) }
			 looks: {}.

	e := ToElement new styleClass: #something.
	self assert: (rule canBeAppliedTo: e) not.
	
	e styleClass: #button.
	self assert: (rule canBeAppliedTo: e).
	
	rule := ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClasses: #( #button )) 
				and: (ToStyleClassSelector new styleClasses: #( #danger ))) }
			 looks: {}.
	self assert: (rule canBeAppliedTo: e) not.
	
	e addStyleClass: #danger.
	self assert: (rule canBeAppliedTo: e).
	
	rule := ToStyleRule new
			 selectors: { 
				(ToStyleClassSelector new styleClasses: #( #button #danger)) }
			 looks: {}.

	self assert: (rule canBeAppliedTo: e).
	e addStyleClass: #something.
	
	self assert: (rule canBeAppliedTo: e).

]

{ #category : #tests }
ToStyleRuleTest >> testRuleWithAndWithChildSelector [
	" a rule with an And operator  "
	| rule e child |
	rule := ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClass: #'button-label') 
				parent: (((ToStyleClassSelector new styleClasses: #( #button )) and: (ToStyleClassSelector new styleClasses: #( #danger )))) level: 1 }
			 looks: {}.
	e := ToElement new styleClass: #button.
	self assert: (rule canBeAppliedTo: e) not.
	e addStyleClass: #danger.
	" ko since no child "
	self assert: (rule canBeAppliedTo: e) not.
	e addChild: (child := ToElement new styleClass: #'button-label').
	" ko since no child "
	self assert: (rule canBeAppliedTo: child)
]

{ #category : #tests }
ToStyleRuleTest >> testRuleWithChildSelector1 [
	" a rule with a universal selector among others accept any element "

	| rule parent child |
	rule := ToStyleRule new
			 selectors: { ((ToStyleClassSelector new styleClass: #child)
					  parent: (ToStyleClassSelector new styleClass: #'direct-parent')
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
			 selectors: { ((ToStyleClassSelector new styleClass: #childchild) parent: (ToStyleClassSelector new styleClass: #child) level: 1) }
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
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 2) }
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
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 1) }
			 looks: { }.
	childchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 2) }
			 looks: { }.
	childchildchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 3) }
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
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 0) }
			 looks: { }.
	childchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 1) }
			 looks: { }.
	childchildchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 2) }
			 looks: { }.
	
	self assert: (childRule canBeAppliedTo: child) not.
	self assert: (childchildRule canBeAppliedTo: childchild) not.
	self assert: (childchildchildRule canBeAppliedTo: childchildchild) not.
	
	childRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 2) }
			 looks: { }.
	childchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 3) }
			 looks: { }.
	childchildchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 4) }
			 looks: { }.
	
	self assert: (childRule canBeAppliedTo: child) not.
	self assert: (childchildRule canBeAppliedTo: childchild) not.
	self assert: (childchildchildRule canBeAppliedTo: childchildchild) not.

	childRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 1) }
			 looks: { }.
	childchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 2) }
			 looks: { }.
	childchildchildRule := ToStyleRule new
			 selectors: { ((ToUniversalSelector new) parent: (ToStyleClassSelector new styleClass: #parent) level: 3) }
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
