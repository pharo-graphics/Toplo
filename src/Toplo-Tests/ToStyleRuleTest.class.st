"
A ToStyleRuleTest is a test class for testing the behavior of ToStyleRule
"
Class {
	#name : #ToStyleRuleTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #running }
ToStyleRuleTest >> setUp [

	super setUp.

]

{ #category : #tests }
ToStyleRuleTest >> testCanBeAppliedTo [

	| rule |
	rule := ToStyleRule new selector: ToUniversalSelector new.
	self assert: (rule canBeAppliedTo: ToElement new)
]

{ #category : #tests }
ToStyleRuleTest >> testCanBeAppliedToInTheme [

	| rule theme1 theme2 theme3 e |
	e := ToElement new.
	theme1 := ToThemeForStyleRuleTest new.
	rule := ToStyleRule new selector: ToUniversalSelector new.
	self assert: (rule canBeAppliedTo: e inTheme: theme1).	
	rule canBeAppliedTo: e inTheme: theme1.
	" now with another theme of the same class "
	theme2 := ToThemeForStyleRuleTest new.
	self assert: (rule canBeAppliedTo: e inTheme: theme2).	
	" now with another theme of a different class "
	theme3 := ToSubThemeForStyleRuleTest new.
	self assert: (rule canBeAppliedTo: e inTheme: theme3)
	
]

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithAndWithParentSelector [
	" a rule with an And operator  "

	| rule e child |
	" select a button label in a button + danger "
	rule := ToStyleRule new selector:
		        ((ToStampSelector new addStamp: #'button-label')
			         withParent: (ToStampSelector new addStamp: #button)
				         && (ToStampSelector new addStamp: #danger)
			         atDepth: 1).
	e := ToElement new addStamp: #button.
	self deny: (rule canBeAppliedTo: e).
	e addStamp: #danger.
	" ko since no child "
	self deny: (rule canBeAppliedTo: e).
	e addChild: (child := ToElement new addStamp: #'button-label').
	" ok now "
	self assert: (rule canBeAppliedTo: child)
]

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithChildSelector1 [
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

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithChildSelector2 [
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

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithChildSelector3 [
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

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithChildSelector4 [
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

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithChildSelector5 [
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

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithClassSelector [

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

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithNoSelector [
	" a rule with no selector accepts any alement "
	| rule e |
	rule := ToStyleRule new.
	e := ToElement new.
	self assert: (rule canBeAppliedTo: e) 
]

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithUniversalSelector [
	" a rule with a unique univesal selector accept any element "

	| rule e |
	rule := ToStyleRule new selector: ToUniversalSelector new.
	e := ToElement new.
	self assert: (rule canBeAppliedTo: e)
]

{ #category : #'tests - rule application' }
ToStyleRuleTest >> testCanBeAppliedToWithRuleWithUniversalSelector2 [
	" a rule with a universal selector among others accept any element "

	| rule e |
	rule := ToStyleRule new selector:
		        (ToIdSelector new id: #a) || ToUniversalSelector new.
	e := ToElement new.
	self assert: (rule canBeAppliedTo: e)
]

{ #category : #tests }
ToStyleRuleTest >> testCanBeRecursivelyAppliedToForTheme [

	| rule theme e |
	theme := ToThemeForStyleRuleTest new.
	e := ToElement new.
	rule := ToStyleRule new selector: ToUniversalSelector new.
	self assert: (rule canBeRecursivelyAppliedTo: e forTheme: theme).
	rule addStyleRule: (ToStyleRule new selector:
			 (ToTypeSelector new type: ToElement)).
	self assert: (rule canBeRecursivelyAppliedTo: e forTheme: theme).
	rule addStyleRule:
		(ToStyleRule new selector: (ToNotSelector new left:
				  (ToTypeSelector new type: ToElement))).
	self deny: (rule canBeRecursivelyAppliedTo: e forTheme: theme)
]

{ #category : #tests }
ToStyleRuleTest >> testPutApplicableListenersForElementForThemeIn [

	| rule subRule w1 w2 e listeners |
	e := ToElement new.
	rule := ToStyleRule new selector: ToUniversalSelector new.
	subRule := ToStyleRule new selector:
		           (ToTypeSelector new type: ToElement).
	rule addStyleRule: subRule.
	listeners := Array streamContents: [ :stream |
		           rule
			           putApplicableListenersForElement: e
			           forTheme: nil
			           in: stream ].
	self assert: listeners isEmpty.
	rule addSkinEventListener: (w1 := ToPropertyWriter new).
	subRule addSkinEventListener: (w2 := ToPropertyWriter new).
	listeners := Array streamContents: [ :stream |
		                      rule
			                      putApplicableListenersForElement: e
			                      forTheme: nil
			                      in: stream ].
	self assert: listeners size equals: 2.
	self assert: (listeners includes: w1).
	self assert: (listeners includes: w2)
]

{ #category : #tests }
ToStyleRuleTest >> testRawStyleRules [

	| rule |
	rule := ToStyleRule new selector: ToUniversalSelector new.
	self assert: rule rawStyleRules isEmpty.
	rule addStyleRule: (ToStyleRule new selector:
			 (ToTypeSelector new type: ToElement)).
	self assert: rule rawStyleRules size equals: 1
]

{ #category : #tests }
ToStyleRuleTest >> testSelector [

	| rule s |
	rule := ToStyleRule new.
	self assert: (rule selector isKindOf: ToUniversalSelector).
	rule selector: (s := ToUniversalSelector new).
	self assert: rule selector identicalTo: s.
]
