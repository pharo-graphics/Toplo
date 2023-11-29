"
A ToStyleRuleTest is a test class for testing the behavior of ToStyleRule
"
Class {
	#name : #ToStyleRuleTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core-StyleSheet'
}

{ #category : #running }
ToStyleRuleTest >> setUp [

	super setUp.

]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithAndWithParentSelector [
	" a rule with an And operator  "

	| rule e child |
	rule := ToStyleRule new selector:
		        ((ToStampSelector new addStamp: #'button-label')
			         withParent: (ToStampSelector new addStamp: #button)
				         + (ToStampSelector new addStamp: #danger)
			         atDepth: 1).
	e := ToElement new addStamp: #button.
	self assert: (rule canBeAppliedTo: e) not.
	e addStamp: #danger.
	" ko since no child "
	self assert: (rule canBeAppliedTo: e) not.
	e addChild: (child := ToElement new addStamp: #'button-label').
	" ko since no child "
	self assert: (rule canBeAppliedTo: child)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithChildSelector1 [
	" a rule with a universal selector among others accept any element "

	| rule parent child |
	rule := ToStyleRule new selector:
		        ((ToStampSelector new addStamp: #child)
			         withParent:
			         (ToStampSelector new addStamp: #'direct-parent')
			         atDepth: 1).
	child := ToElement new.
	child addStamp: #child.
	parent := ToElement new.
	parent addStamp: #'direct-parent'.
	parent addChild: child.
	self assert: (rule canBeAppliedTo: child)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithChildSelector2 [
	" a rule with a universal selector among others accept any element "

	| rule child childchild |
	rule := ToStyleRule new selector:
		        ((ToStampSelector new addStamp: #childchild)
			         withParent: (ToStampSelector new addStamp: #child)
			         atDepth: 1).

	childchild := ToElement new.
	childchild addStamp: #childchild.
	child := ToElement new.
	child addStamp: #child.
	self assert: (rule canBeAppliedTo: childchild) not.
	child addChild: childchild.
	self assert: (rule canBeAppliedTo: childchild)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithChildSelector3 [
	" a rule with a universal selector among others accept any element "

	| rule parent child childchild |
	rule := ToStyleRule new selector: (ToUniversalSelector new
			         withParent: (ToStampSelector new addStamp: #parent)
			         atDepth: 2).
	childchild := BlElement new.
	childchild addStamp: #childchild.
	child := BlElement new.
	child addStamp: #child.
	child addChild: childchild.
	parent := BlElement new.
	parent addStamp: #parent.
	parent addChild: child.
	self assert: childchild parent == child.
	self assert: child parent == parent.
	self assert: (rule canBeAppliedTo: childchild)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithChildSelector4 [
	" a rule with a universal selector among others accept any element "

	| parent child childchild childchildchild childRule childchildRule childchildchildRule |
	childRule := ToStyleRule new selector: (ToUniversalSelector new
			              withParent: (ToStampSelector new addStamp: #parent)
			              atDepth: 1).
	childchildRule := ToStyleRule new selector: (ToUniversalSelector new
			                   withParent:
			                   (ToStampSelector new addStamp: #parent)
			                   atDepth: 2).
	childchildchildRule := ToStyleRule new selector:
		                       (ToUniversalSelector new
			                        withParent:
			                        (ToStampSelector new addStamp: #parent)
			                        atDepth: 3).

	childchildchild := BlElement new.
	childchildchild addStamp: #childchildchild.
	childchild := BlElement new.
	childchild addStamp: #childchild.
	child := BlElement new.
	child addStamp: #child.
	child addChild: childchild.
	childchild addChild: childchildchild.
	parent := BlElement new.
	parent addStamp: #parent.
	parent addChild: child.
	self assert: childchildchild parent identicalTo: childchild.
	self assert: childchild parent identicalTo: child.
	self assert: child parent identicalTo: parent.
	self assert: (childRule canBeAppliedTo: child).
	self assert: (childchildRule canBeAppliedTo: childchild).
	self assert: (childchildchildRule canBeAppliedTo: childchildchild)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithChildSelector5 [
	" a rule with a universal selector among others accept any element "

	| parent child childchild childchildchild childRule childchildRule childchildchildRule |
	childchildchild := BlElement new.
	childchildchild addStamp: #childchildchild.
	childchild := BlElement new.
	childchild addStamp: #childchild.
	child := BlElement new.
	child addStamp: #child.
	child addChild: childchild.
	childchild addChild: childchildchild.
	parent := BlElement new.
	parent addStamp: #parent.
	parent addChild: child.
	self assert: childchildchild parent identicalTo: childchild.
	self assert: childchild parent identicalTo: child.
	self assert: child parent identicalTo: parent.

	childRule := ToStyleRule new selector: (ToUniversalSelector new
			              withParent: (ToStampSelector new addStamp: #parent)
			              atDepth: 0).

	childchildRule := ToStyleRule new selector: (ToUniversalSelector new
			                   withParent:
			                   (ToStampSelector new addStamp: #parent)
			                   atDepth: 1).
	childchildchildRule := ToStyleRule new selector:
		                       (ToUniversalSelector new
			                        withParent:
			                        (ToStampSelector new addStamp: #parent)
			                        atDepth: 2).

	self assert: (childRule canBeAppliedTo: child) not.
	self assert: (childchildRule canBeAppliedTo: childchild) not.
	self assert:
		(childchildchildRule canBeAppliedTo: childchildchild) not.

	childRule := ToStyleRule new selector: (ToUniversalSelector new
			              withParent: (ToStampSelector new addStamp: #parent)
			              atDepth: 2).
	childchildRule := ToStyleRule new selector: (ToUniversalSelector new
			                   withParent:
			                   (ToStampSelector new addStamp: #parent)
			                   atDepth: 3).
	childchildchildRule := ToStyleRule new selector:
		                       (ToUniversalSelector new
			                        withParent:
			                        (ToStampSelector new addStamp: #parent)
			                        atDepth: 4).

	self assert: (childRule canBeAppliedTo: child) not.
	self assert: (childchildRule canBeAppliedTo: childchild) not.
	self assert:
		(childchildchildRule canBeAppliedTo: childchildchild) not.

	childRule := ToStyleRule new selector: (ToUniversalSelector new
			              withParent: (ToStampSelector new addStamp: #parent)
			              atDepth: 1).
	childchildRule := ToStyleRule new selector: (ToUniversalSelector new
			                   withParent:
			                   (ToStampSelector new addStamp: #parent)
			                   atDepth: 2).
	childchildchildRule := ToStyleRule new selector:
		                       (ToUniversalSelector new
			                        withParent:
			                        (ToStampSelector new addStamp: #parent)
			                        atDepth: 3).

	self assert: (childRule canBeAppliedTo: child).
	self assert: (childchildRule canBeAppliedTo: childchild).
	self assert: (childchildchildRule canBeAppliedTo: childchildchild)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithClassSelector [

	| rule e |
	rule := ToStyleRule new selector:
		        (ToStampSelector new addStamp: #button ).

	e := ToElement new addStamp: #something.
	self assert: (rule canBeAppliedTo: e) not.

	e addStamp: #button.
	self assert: (rule canBeAppliedTo: e).
	e addStamp: #danger.
	self assert: (rule canBeAppliedTo: e)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithNoSelector [
	" a rule with no selector accepts any alement "
	| rule e |
	rule := ToStyleRule new.
	e := ToElement new.
	self assert: (rule canBeAppliedTo: e) 
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithUniversalSelector [
	" a rule with a unique univesal selector accept any element "

	| rule e |
	rule := ToStyleRule new selector: ToUniversalSelector new.
	e := ToElement new.
	self assert: (rule canBeAppliedTo: e)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithUniversalSelector2 [
	" a rule with a universal selector among others accept any element "

	| rule e |
	rule := ToStyleRule new
		        selector: ((ToIdSelector new id: #a) or: ToUniversalSelector new).
	e := ToElement new.
	self assert: (rule canBeAppliedTo: e)
]
