"
A ToStyleScriptTest is a test class for testing the behavior of ToStyleScript
"
Class {
	#name : 'ToStyleScriptTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'tests' }
ToStyleScriptTest >> testAny [
	" a rule with an And operator  "

	| selector |
	selector := ToStyleScript new any.
	self assert: (selector isKindOf: ToUniversalSelector )
]

{ #category : 'tests' }
ToStyleScriptTest >> testRuleWithAndSelector [
	" a rule with an And operator  "

	| rule e |
	rule := ToStyleScript new select: (ToStampSelector new addStamp: #button )
		        style: [ :sr |  ].

	e := ToElement new addStamp: #something.
	self assert: (rule canBeAppliedTo: e) not.

	e addStamp: #button.
	self assert: (rule canBeAppliedTo: e).

	rule := ToStyleScript new 
		        select: (ToStampSelector new addStamp: #button )
			        + (ToStampSelector new addStamp: #danger )
		        style: [ :sr |  ].
	self assert: (rule canBeAppliedTo: e) not.

	e addStamp: #danger.
	self assert: (rule canBeAppliedTo: e).

	rule := ToStyleScript new
		        select: (ToStampSelector new addAllStamps: #( #button #danger ))
		        style: [ :sr |  ].

	self assert: (rule canBeAppliedTo: e).
	e addStamp: #something.

	self assert: (rule canBeAppliedTo: e)
]

{ #category : 'tests' }
ToStyleScriptTest >> testRuleWithSubRule [
	" a rule with an And operator  "

	| rule parent child |
	rule := ToStyleScript new
		        select: (ToStampSelector new addStamp: #parent)
		        style: [ :sr |
			        sr
				        select:
				        (sr withChild: (ToStampSelector new addStamp: #child)
					         atDepth: 1)
				        style: [  ] ].
	parent := ToElement new addStamp: #parent.
	self deny: (rule canBeFullyAppliedTo: parent forTheme: nil).
	child := ToElement new addStamp: #child.
	parent addChild: child.
	self assert: (rule canBeFullyAppliedTo: parent forTheme: nil)
]

{ #category : 'tests' }
ToStyleScriptTest >> testRuleWithSubRule2 [
	" a rule with an And operator  "

	| rule  |
	self flag: 'add assertions'.
	rule := ToStyleScript new
		        select: #button asElementSelector 
		        style: [ :sr |
			        sr
				        select: #checkable asElementSelector 
				        style: [ :sr2 |  ] ].


]
