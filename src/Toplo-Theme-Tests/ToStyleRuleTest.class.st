"
A ToStyleRuleTest is a test class for testing the behavior of ToStyleRule
"
Class {
	#name : #ToStyleRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'writeablePropertyIndex'
	],
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

{ #category : #running }
ToStyleRuleTest >> setUp [

	super setUp.
	writeablePropertyIndex := ToPropertyIndex new
		                          recordAll: ToStyleSheet defaultWritablePropertyList;
		                          yourself
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testNewStyleRuleFromSelector [
	".button:initial {
		background: blue;
		border: red;
	}"

	ToStyleRule new
		selectedWith: (ToStyleTagSelector new styleTag: #button)
		style: [ :sr |
			sr
				write: (self writablePropertyIndex propertyNamed: #background)
				with: Color blue.
			sr
				write: (self writablePropertyIndex propertyNamed: #border)
				with: Color red ]
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithAndSelector [
	" a rule with an And operator  "

	| rule e |
	rule := ToStyleScript new select: (ToStyleTagSelector new styleTags: #( #button ))
		        style: [ :sr |  ].

	e := ToElement new styleTag: #something.
	self assert: (rule canBeAppliedTo: e) not.

	e styleTag: #button.
	self assert: (rule canBeAppliedTo: e).

	rule := ToStyleScript new 
		        select: (ToStyleTagSelector new styleTags: #( #button ))
			        + (ToStyleTagSelector new styleTags: #( #danger ))
		        style: [ :sr |  ].
	self assert: (rule canBeAppliedTo: e) not.

	e addStyleTag: #danger.
	self assert: (rule canBeAppliedTo: e).

	rule := ToStyleScript new
		        select: (ToStyleTagSelector new styleTags: #( #button #danger ))
		        style: [ :sr |  ].

	self assert: (rule canBeAppliedTo: e).
	e addStyleTag: #something.

	self assert: (rule canBeAppliedTo: e)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithAndWithParentSelector [
	" a rule with an And operator  "

	| rule e child |
	rule := ToStyleRule new selector:
		        ((ToStyleTagSelector new styleTag: #'button-label')
			         parent: (ToStyleTagSelector new styleTags: #( #button ))
				         + (ToStyleTagSelector new styleTags: #( #danger ))
			         depth: 1).
	e := ToElement new styleTag: #button.
	self assert: (rule canBeAppliedTo: e) not.
	e addStyleTag: #danger.
	" ko since no child "
	self assert: (rule canBeAppliedTo: e) not.
	e addChild: (child := ToElement new styleTag: #'button-label').
	" ko since no child "
	self assert: (rule canBeAppliedTo: child)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithChildSelector1 [
	" a rule with a universal selector among others accept any element "

	| rule parent child |
	rule := ToStyleRule new
			 selector:  ((ToStyleTagSelector new styleTag: #child)
					  parent: (ToStyleTagSelector new styleTag: #'direct-parent')
					  depth: 1).
	child := ToElement new.
	child styleTag: #child.
	parent := ToElement new.
	parent styleTag: #'direct-parent'.
	parent addChild: child.
	self assert: (rule canBeAppliedTo: child)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithChildSelector2 [
	" a rule with a universal selector among others accept any element "

	| rule child childchild |
	rule := ToStyleRule new selector:
		        ((ToStyleTagSelector new styleTag: #childchild)
			         parent: (ToStyleTagSelector new styleTag: #child)
			         depth: 1).

	childchild := ToElement new.
	childchild styleTag: #childchild.
	child := ToElement new.
	child styleTag: #child.
	self assert: (rule canBeAppliedTo: childchild) not.
	child addChild: childchild.
	self assert: (rule canBeAppliedTo: childchild)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithChildSelector3 [
	" a rule with a universal selector among others accept any element "

	| rule parent child childchild |

	rule := ToStyleRule new
			 selector:  ((ToUniversalSelector new) parent: (ToStyleTagSelector new styleTag: #parent) depth: 2).
	childchild := BlElement new.
	childchild styleTag: #childchild.
	child := BlElement new.
	child styleTag: #child.
	child addChild: childchild.
	parent := BlElement new.
	parent styleTag: #parent.
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
			              parent:
			              (ToStyleTagSelector new styleTag: #parent)
			              depth: 1).
	childchildRule := ToStyleRule new selector: (ToUniversalSelector new
			                   parent:
			                   (ToStyleTagSelector new styleTag: #parent)
			                   depth: 2).
	childchildchildRule := ToStyleRule new selector:
		                       (ToUniversalSelector new
			                        parent:
			                        (ToStyleTagSelector new styleTag:
				                         #parent)
			                        depth: 3).

	childchildchild := BlElement new.
	childchildchild styleTag: #childchildchild.
	childchild := BlElement new.
	childchild styleTag: #childchild.
	child := BlElement new.
	child styleTag: #child.
	child addChild: childchild.
	childchild addChild: childchildchild.
	parent := BlElement new.
	parent styleTag: #parent.
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
	childchildchild styleTag: #childchildchild.
	childchild := BlElement new.
	childchild styleTag: #childchild.
	child := BlElement new.
	child styleTag: #child.
	child addChild: childchild.
	childchild addChild: childchildchild.
	parent := BlElement new.
	parent styleTag: #parent.
	parent addChild: child.
	self assert: childchildchild parent identicalTo: childchild.
	self assert: childchild parent identicalTo: child.
	self assert: child parent identicalTo: parent.

	childRule := ToStyleRule new selector: (ToUniversalSelector new
			              parent:
			              (ToStyleTagSelector new styleTag: #parent)
			              depth: 0).

	childchildRule := ToStyleRule new selector: (ToUniversalSelector new
			                   parent:
			                   (ToStyleTagSelector new styleTag: #parent)
			                   depth: 1).
	childchildchildRule := ToStyleRule new selector:
		                       (ToUniversalSelector new
			                        parent:
			                        (ToStyleTagSelector new styleTag:
				                         #parent)
			                        depth: 2).

	self assert: (childRule canBeAppliedTo: child) not.
	self assert: (childchildRule canBeAppliedTo: childchild) not.
	self assert:
		(childchildchildRule canBeAppliedTo: childchildchild) not.

	childRule := ToStyleRule new selector: (ToUniversalSelector new
			              parent:
			              (ToStyleTagSelector new styleTag: #parent)
			              depth: 2).
	childchildRule := ToStyleRule new selector: (ToUniversalSelector new
			                   parent:
			                   (ToStyleTagSelector new styleTag: #parent)
			                   depth: 3).
	childchildchildRule := ToStyleRule new selector:
		                       (ToUniversalSelector new
			                        parent:
			                        (ToStyleTagSelector new styleTag:
				                         #parent)
			                        depth: 4).

	self assert: (childRule canBeAppliedTo: child) not.
	self assert: (childchildRule canBeAppliedTo: childchild) not.
	self assert:
		(childchildchildRule canBeAppliedTo: childchildchild) not.

	childRule := ToStyleRule new selector: (ToUniversalSelector new
			              parent:
			              (ToStyleTagSelector new styleTag: #parent)
			              depth: 1).
	childchildRule := ToStyleRule new selector: (ToUniversalSelector new
			                   parent:
			                   (ToStyleTagSelector new styleTag: #parent)
			                   depth: 2).
	childchildchildRule := ToStyleRule new selector:
		                       (ToUniversalSelector new
			                        parent:
			                        (ToStyleTagSelector new styleTag:
				                         #parent)
			                        depth: 3).

	self assert: (childRule canBeAppliedTo: child).
	self assert: (childchildRule canBeAppliedTo: childchild).
	self assert: (childchildchildRule canBeAppliedTo: childchildchild)
]

{ #category : #'tests - simple rule' }
ToStyleRuleTest >> testRuleWithClassSelector [

	| rule e |
	rule := ToStyleRule new selector:
		        (ToStyleTagSelector new styleTags: #( #button )).

	e := ToElement new styleTag: #something.
	self assert: (rule canBeAppliedTo: e) not.

	e styleTag: #button.
	self assert: (rule canBeAppliedTo: e).
	e addStyleTag: #danger.
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

{ #category : #'test - rule hierarchy' }
ToStyleRuleTest >> testRuleWithSubRule [
	" a rule with an And operator  "

	| rule |
	self flag: 'add assertions'.
	rule := ToStyleScript new
		        select: (ToStyleTagSelector new styleTags: #( #button ))
		        style: [ :sr |
			        sr
				        select: (ToStyleTagSelector new styleTags: #( #checkable ))
				        style: [ :sr2 |  ] ].

]

{ #category : #'test - rule hierarchy' }
ToStyleRuleTest >> testRuleWithSubRule2 [
	" a rule with an And operator  "

	| rule  |
	self flag: 'add assertions'.
	rule := ToStyleScript new
		        select: #button asStyleSelector 
		        style: [ :sr |
			        sr
				        select: #checkable asStyleSelector 
				        style: [ :sr2 |  ] ].


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

{ #category : #running }
ToStyleRuleTest >> writablePropertyIndex [ 

	^ writeablePropertyIndex 
]
