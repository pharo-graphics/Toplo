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
ToStyleScriptTest >> testAction [
	" a rule with an And operator  "

	| selector |
	selector := ToStyleScript new action: [ :element | true ].
	self assert: (selector isKindOf: ToActionSelector ).
]

{ #category : 'tests' }
ToStyleScriptTest >> testAny [
	" a rule with an And operator  "

	| selector |
	selector := ToStyleScript new any.
	self assert: (selector isKindOf: ToUniversalSelector )
]

{ #category : 'tests' }
ToStyleScriptTest >> testRuleStack [

	| styleScript |
	styleScript := ToStyleScript new.
	self assert: styleScript ruleStack isEmpty
]

{ #category : 'tests' }
ToStyleScriptTest >> testRuleStackWithSelectStyle [

	| styleScript styleRule rhs |
	rhs := ToIdSelector new id: #button.
	styleScript := ToStyleScript new.
	styleRule := styleScript select: #button style: [ :theStyleScript |
		theStyleScript select: #danger asElementSelector style: [  ].
		theStyleScript select: #dashed asElementSelector style: [  ] ].
	self assert: (styleRule selector isKindOf: ToStampSelector).
	self assert: (styleRule selector allStamps includes: #button).
	self assert: styleRule styleRules size equals: 2.
]

{ #category : 'tests' }
ToStyleScriptTest >> testRuleStackWithSelectStyle2 [

	| styleScript styleRule wasHere top |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleRule := styleScript select: #button style: [ :theStyleScript | 
		wasHere := true. 
		self assert: theStyleScript identicalTo: styleScript.
		self assert: theStyleScript ruleStack size equals: 1.
		self assert: (theStyleScript ruleStack top isKindOf: ToStyleRule).
		top := theStyleScript ruleStack top ].
	self assert: wasHere.
	self assert: top identicalTo: styleRule.
	self assert: (styleRule selector isKindOf: ToStampSelector).
	self assert: styleRule styleRules isEmpty.
]

{ #category : 'tests' }
ToStyleScriptTest >> testSelectStyle [

	| styleRule rhs |
	rhs := ToIdSelector new id: #button.
	styleRule := ToStyleScript new select: #button style: [:theStyleScript |].
	self assert: (styleRule selector isKindOf: ToStampSelector ).	
	self assert: (styleRule selector allStamps includes: #button).
]

{ #category : 'tests' }
ToStyleScriptTest >> testSelectStyleWithAndSelector [
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
ToStyleScriptTest >> testSelectStyleWithSubRule [

	| styleScript styleRule  |
	styleScript := ToStyleScript new.
	styleRule := styleScript select: #button style: [ :theStyleScript |
		theStyleScript select: #danger asElementSelector style: [  ].
		theStyleScript select: #dashed asElementSelector style: [  ] ].
	self assert: (styleRule selector isKindOf: ToStampSelector).
	self assert: (styleRule selector allStamps includes: #button).
	self assert: styleRule styleRules size equals: 2
]

{ #category : 'tests' }
ToStyleScriptTest >> testSelectStyleWithSubRule2 [
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

{ #category : 'tests' }
ToStyleScriptTest >> testSelectStyleWithSubRule3 [
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
	self deny: (rule canBeRecursivelyAppliedTo: parent forTheme: nil).
	child := ToElement new addStamp: #child.
	parent addChild: child.
	self assert: (rule canBeRecursivelyAppliedTo: parent forTheme: nil)
]

{ #category : 'tests' }
ToStyleScriptTest >> testWithChild [

	| selector rhs |
	rhs := ToIdSelector new id: #'button-label'.
	selector := ToStyleScript new withChild: rhs.
	self assert: (selector isKindOf: ToChildSelector ).
	self assert: (selector left isKindOf: ToUniversalSelector).
	self assert: selector right identicalTo: rhs.
	self assert: selector depth isNil
]

{ #category : 'tests' }
ToStyleScriptTest >> testWithChildAtDepth [

	| selector rhs |
	rhs := ToIdSelector new id: #'button-label'.
	selector := ToStyleScript new withChild: rhs atDepth: 2.
	self assert: (selector isKindOf: ToChildSelector ).
	self assert: (selector left isKindOf: ToUniversalSelector).
	self assert: selector right identicalTo: rhs.
	self assert: selector depth equals: 2
]

{ #category : 'tests' }
ToStyleScriptTest >> testWithParent [

	| selector rhs |
	rhs := ToIdSelector new id: #'button'.
	selector := ToStyleScript new withParent: rhs.
	self assert: (selector isKindOf: ToParentSelector ).
	self assert: (selector left isKindOf: ToUniversalSelector).
	self assert: selector right identicalTo: rhs.
	self assert: selector depth isNil
]

{ #category : 'tests' }
ToStyleScriptTest >> testWithParentAtDepth [

	| selector rhs |
	rhs := ToIdSelector new id: #'button'.
	selector := ToStyleScript new withParent: rhs atDepth: 2.
	self assert: (selector isKindOf: ToParentSelector ).
	self assert: (selector left isKindOf: ToUniversalSelector).
	self assert: selector right identicalTo: rhs.
	self assert: selector depth equals: 2
]
