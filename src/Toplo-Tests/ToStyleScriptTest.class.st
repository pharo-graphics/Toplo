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
ToStyleScriptTest >> testAddPropertyWriter [

	| styleScript styleRule writer |
	styleScript := ToStyleScript new.
	styleRule := styleScript select: #button style: [ :theStyleScript |
		             theStyleScript addPropertyWriter:
			             (ToPropertyWriter new
				              property: (ToFeatureProperty new name: #size);
				              value: 40 asPoint;
				              yourself) ].
	self assert: styleRule propertyWriters size equals: 1.
	writer := styleRule propertyWriters first.
	self assert: (writer property isKindOf: ToFeatureProperty).
	self assert: writer property name equals: #size.
	self assert: writer value equals: 40 asPoint
]

{ #category : 'tests' }
ToStyleScriptTest >> testAny [
	" a rule with an And operator  "

	| selector |
	selector := ToStyleScript new any.
	self assert: (selector isKindOf: ToUniversalSelector )
]

{ #category : 'tests' }
ToStyleScriptTest >> testEventClass [

	| script rule  eventClass1 eventClass2 |
	script := ToStyleScript new.
	" the stack is empty -> not event class "
	self should: [script eventClass] raise: Error.
	rule := script select: #button style: [ :sr |
		        eventClass1 := sr eventClass.
		        sr select: #danger style: [ eventClass2 := sr eventClass ] ].
	self assert: eventClass1 identicalTo: ToInstallLookEvent.
	self assert: eventClass2 identicalTo: ToInstallLookEvent
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
ToStyleScriptTest >> testRuleStackWithSelectStyleWithSubSelect [

	| styleScript styleRule wasHere top |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleRule := styleScript select: #button style: [ :scr |
		             scr select: #label style: [
			             wasHere := true.
			             self assert: scr ruleStack size equals: 2.
			             top := scr ruleStack top ] ].
	self assert: wasHere.
	self assert: top identicalTo: styleRule styleRules first.
	self assert: (top selector isKindOf: ToStampSelector).
	self assert: (top selector allStamps includes: #label).
	self assert: styleRule styleRules size equals: 1
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
ToStyleScriptTest >> testSelectStyleWithWriters [

	| styleScript styleRule wasHere writer |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleRule := styleScript select: #button style: [ :theStyleScript |
		             wasHere := true.
		             theStyleScript
			             write: (ToFeatureProperty new name: #size)
			             with: 40 asPoint ].
	self assert: wasHere.
	self assert: styleRule propertyWriters size equals: 1.
	writer := styleRule propertyWriters first.
	self assert: (writer property isKindOf: ToFeatureProperty).
	self assert: writer property name equals: #size.
	self assert: writer value equals: 40 asPoint
]

{ #category : 'tests' }
ToStyleScriptTest >> testSelectStyleWithWriters2 [

	| styleScript styleRule wasHere writer |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleRule := styleScript select: #button style: [ :theStyleScript |
		             wasHere := true.
		             theStyleScript
			             write: (ToFeatureProperty new name: #size)
			             with: [ :e | 40 asPoint ] ].
	self assert: wasHere.
	self assert: styleRule propertyWriters size equals: 1.
	writer := styleRule propertyWriters first.
	self assert: (writer property isKindOf: ToFeatureProperty).
	self assert: writer property name equals: #size.
	self assert: (writer value isKindOf: BlockClosure).
	self assert: writer eventClass identicalTo: ToInstallLookEvent 
]

{ #category : 'tests' }
ToStyleScriptTest >> testSelectStyleWithWriters3 [

	| styleScript styleRule wasHere writer |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleRule := styleScript select: #button style: [ :theStyleScript |
		             wasHere := true.
		             theStyleScript
			             when: ToEnabledLookEvent
			             write: (ToFeatureProperty new name: #size)
			             with: [ :e | 40 asPoint ] ].
	self assert: wasHere.
	self assert: styleRule propertyWriters size equals: 1.
	writer := styleRule propertyWriters first.
	self assert: writer eventClass identicalTo: ToEnabledLookEvent
]

{ #category : 'tests' }
ToStyleScriptTest >> testSelectStyleWithWriters4 [

	| styleScript styleRule dangerRule dangerWriter |
	styleScript := ToStyleScript new.
	styleRule := styleScript select: #button style: [ :theStyleScript |
		             theStyleScript
			             write: (ToFeatureProperty new name: #border)
			             with: Color black.
		             theStyleScript
			             write: (ToFeatureProperty new name: #background)
			             with: Color gray.
		             theStyleScript select: #danger style: [
			             theStyleScript
				             write: (ToFeatureProperty new name: #border)
				             with: Color red ] ].
	self assert: styleRule propertyWriters size equals: 2.
	self
		assert: styleRule propertyWriters first eventClass
		identicalTo: ToInstallLookEvent.
	self
		assert: styleRule propertyWriters second eventClass
		identicalTo: ToInstallLookEvent.

	self assert: styleRule styleRules size equals: 1.
	dangerRule := styleRule styleRules first.
	self assert: (dangerRule selector isKindOf: ToStampSelector).
	self assert: dangerRule propertyWriters size equals: 1.
	dangerWriter := dangerRule propertyWriters first.
	self assert: dangerWriter eventClass identicalTo: ToInstallLookEvent.
	self assert: (dangerWriter property isKindOf: ToFeatureProperty).
	self assert: dangerWriter property name equals: #border.
	self assert: dangerWriter value equals: Color red
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
