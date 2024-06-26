"
A ToStyleScriptTest is a test class for testing the behavior of ToStyleScript
"
Class {
	#name : #ToStyleScriptTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #tests }
ToStyleScriptTest >> testAction [
	" a rule with an And operator  "

	| selector |
	selector := ToStyleScript new action: [ :element | true ].
	self assert: (selector isKindOf: ToActionSelector ).
]

{ #category : #tests }
ToStyleScriptTest >> testAddPropertyWriter1 [

	| styleScript |
	styleScript := ToStyleScript new.
	" can't add a property write outside a select:style: block because 
	there is no access to any style rule outside a select:style: block"
	self should: [styleScript addSkinEventListener: ToPropertyWriter new] raise: Error
]

{ #category : #tests }
ToStyleScriptTest >> testAddSkinEventListener [

	| styleScript styleRule writer |
	styleScript := ToStyleScript new.
	styleScript select: #button style: [ :theStyleScript |
		theStyleScript addSkinEventListener: (ToPropertyWriter new
				 property: (ToFeatureProperty new name: #size);
				 value: 40 asPoint;
				 yourself) ].
	styleRule := styleScript styleRules first.
	self assert: styleRule skinEventListeners size equals: 1.
	writer := styleRule skinEventListeners first.
	self assert: (writer property isKindOf: ToFeatureProperty).
	self assert: writer property name equals: #size.
	self assert: writer value equals: 40 asPoint
]

{ #category : #tests }
ToStyleScriptTest >> testAny [
	" a rule with an And operator  "

	| selector |
	selector := ToStyleScript new any.
	self assert: (selector isKindOf: ToUniversalSelector )
]

{ #category : #tests }
ToStyleScriptTest >> testRuleStack [

	| styleScript |
	styleScript := ToStyleScript new.
	self assert: styleScript ruleStack isEmpty
]

{ #category : #tests }
ToStyleScriptTest >> testRuleStackWithSelectStyle [

	| styleScript styleRule rhs |
	rhs := ToIdSelector new id: #button.
	styleScript := ToStyleScript new.
	styleScript select: #button asStampSelector style: [ :theStyleScript |
		theStyleScript select: #danger asStampSelector style: [  ].
		theStyleScript select: #dashed asStampSelector style: [  ] ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: (styleRule selector isKindOf: ToStampSelector).
	self assert: (styleRule selector allStamps includes: #button).
	self assert: styleRule styleRules size equals: 2
]

{ #category : #tests }
ToStyleScriptTest >> testRuleStackWithSelectStyle2 [

	| styleScript styleRule wasHere top |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleScript select: #button asStampSelector style: [ :theStyleScript |
		wasHere := true.
		self assert: theStyleScript identicalTo: styleScript.
		self assert: theStyleScript ruleStack size equals: 1.
		self assert: (theStyleScript ruleStack top isKindOf: ToStyleRule).
		top := theStyleScript ruleStack top ].
	self assert: wasHere.
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: top identicalTo: styleRule.
	self assert: (styleRule selector isKindOf: ToStampSelector).
	self assert: styleRule styleRules isEmpty
]

{ #category : #tests }
ToStyleScriptTest >> testRuleStackWithSelectStyleWithSubSelect [

	| styleScript styleRule wasHere top |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleScript select: #button asStampSelector style: [ :scr |
		scr select: #label asStampSelector style: [
			wasHere := true.
			self assert: scr ruleStack size equals: 2.
			top := scr ruleStack top ] ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: wasHere.
	self assert: top identicalTo: styleRule styleRules first.
	self assert: (top selector isKindOf: ToStampSelector).
	self assert: (top selector allStamps includes: #label).
	self assert: styleRule styleRules size equals: 1
]

{ #category : #tests }
ToStyleScriptTest >> testSelectStyle [

	| styleRule rhs styleScript |
	rhs := ToIdSelector new id: #button.
	(styleScript := ToStyleScript new)
		             select: #button asStampSelector
		             style: [ :theStyleScript |  ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: (styleRule selector isKindOf: ToStampSelector).
	self assert: (styleRule selector allStamps includes: #button)
]

{ #category : #tests }
ToStyleScriptTest >> testSelectStyleWithAndSelector [
	" a rule with an And operator  "

	| rule e styleScript |
	(styleScript := ToStyleScript new)
		select: (ToStampSelector new addStamp: #button)
		style: [ :sr |  ].

	self assert: styleScript styleRules size equals: 1.
	rule := styleScript styleRules first.
	e := ToElement new addStamp: #something.
	self assert: (rule canBeAppliedTo: e) not.

	e addStamp: #button.
	self assert: (rule canBeAppliedTo: e).

	styleScript := ToStyleScript new.
	styleScript
		select: (ToStampSelector new addStamp: #button)
			&& (ToStampSelector new addStamp: #danger)
		style: [ :sr |  ].
	self assert: styleScript styleRules size equals: 1.
	rule := styleScript styleRules first.
	self assert: (rule canBeAppliedTo: e) not.

	e addStamp: #danger.
	self assert: (rule canBeAppliedTo: e).

	styleScript := ToStyleScript new.
	styleScript
		select: (ToStampSelector new addAllStamps: #( #button #danger ))
		style: [ :sr |  ].

	self assert: styleScript styleRules size equals: 1.
	rule := styleScript styleRules first.

	self assert: (rule canBeAppliedTo: e).
	e addStamp: #something.

	self assert: (rule canBeAppliedTo: e)
]

{ #category : #tests }
ToStyleScriptTest >> testSelectStyleWithSubRule [

	| styleScript styleRule |
	styleScript := ToStyleScript new.
	styleScript select: #button asStampSelector style: [ :theStyleScript |
		theStyleScript select: #danger asStampSelector style: [  ].
		theStyleScript select: #dashed asStampSelector style: [  ] ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: (styleRule selector isKindOf: ToStampSelector).
	self assert: (styleRule selector allStamps includes: #button).
	self assert: styleRule styleRules size equals: 2
]

{ #category : #tests }
ToStyleScriptTest >> testSelectStyleWithSubRule2 [
	" a rule with an And operator  "

	| styleScript |
	self flag: 'add assertions'.
	(styleScript := ToStyleScript new)
		select: #button asStampSelector
		style: [ :sr |
		sr select: #checkable asStampSelector style: [ :sr2 |  ] ]
]

{ #category : #tests }
ToStyleScriptTest >> testSelectStyleWithSubRule3 [
	" a rule with an And operator  "

	| rule parent child styleScript |
	(styleScript := ToStyleScript new)
		select: (ToStampSelector new addStamp: #parent)
		style: [ :sr |
			sr
				select:
				(sr withChild: (ToStampSelector new addStamp: #child) atDepth: 1)
				style: [  ] ].
	self assert: styleScript styleRules size equals: 1.
	rule := styleScript styleRules first.
	parent := ToElement new addStamp: #parent.
	self deny: (rule canBeRecursivelyAppliedTo: parent forTheme: nil).
	child := ToElement new addStamp: #child.
	parent addChild: child.
	self assert: (rule canBeRecursivelyAppliedTo: parent forTheme: nil)
]

{ #category : #tests }
ToStyleScriptTest >> testSupplementWith [

	| styleScript styleRule wasHere writer |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleScript select: #button style: [ :theStyleScript |
		wasHere := true.
		theStyleScript
			supplement: (ToPseudoProperty
					 name: #'border-with-builder'
					 reader: [ :e | e border ]
					 writer: [ :e :v | e border: v build ])
			with: [ :e |
				e borderBuilder
					width: 1;
					paint: Color red ] ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: wasHere.
	self assert: styleRule skinEventListeners size equals: 1.
	writer := styleRule skinEventListeners first.
	self assert: writer supplement.
	self assert: writer eventClass equals: ToInstallSkinEvent.
	self assert: (writer property isKindOf: ToPseudoProperty).
	self assert: writer property name equals: #'border-with-builder'.
	self assert: (writer value isKindOf: BlockClosure)
]

{ #category : #tests }
ToStyleScriptTest >> testWhenDo [

	| styleScript styleRule wasHere listener |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleScript select: #button style: [ :theStyleScript |
		wasHere := true.
		theStyleScript
			when: ToEnabledSkinEvent
			do: [ :e | e size: 40 asPoint ]].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: wasHere.
	self assert: styleRule skinEventListeners size equals: 1.
	listener := styleRule skinEventListeners first.
	self deny: listener isSupplement.
	self assert: listener eventClass identicalTo: ToEnabledSkinEvent
]

{ #category : #tests }
ToStyleScriptTest >> testWhenSupplementWith [

	| styleScript styleRule wasHere writer |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleScript select: #button style: [ :theStyleScript |
		wasHere := true.
		theStyleScript
			when: ToHoveredSkinEvent
			supplement: (ToPseudoProperty
					 name: #'border-with-builder'
					 reader: [ :e | e border ]
					 writer: [ :e :v | e border: v build ])
			with: [ :e |
				e borderBuilder
					width: 1;
					paint: Color red ] ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: wasHere.
	self assert: styleRule skinEventListeners size equals: 1.
	writer := styleRule skinEventListeners first.
	self assert: writer supplement.
	self assert: writer eventClass equals: ToHoveredSkinEvent.
	self assert: (writer property isKindOf: ToPseudoProperty).
	self assert: writer property name equals: #'border-with-builder'.
	self assert: (writer value isKindOf: BlockClosure)
]

{ #category : #tests }
ToStyleScriptTest >> testWhenWriteWith [

	| styleScript styleRule wasHere writer |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleScript select: #button style: [ :theStyleScript |
		wasHere := true.
		theStyleScript
			when: ToEnabledSkinEvent
			write: (ToFeatureProperty new name: #size)
			with: [ :e | 40 asPoint ] ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: wasHere.
	self assert: styleRule skinEventListeners size equals: 1.
	writer := styleRule skinEventListeners first.
	self deny: writer supplement.
	self assert: writer eventClass identicalTo: ToEnabledSkinEvent
]

{ #category : #tests }
ToStyleScriptTest >> testWhenWriteWithAnimation [

	| styleScript styleRule wasHere writer |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleScript select: #button style: [ :theStyleScript |
		wasHere := true.
		theStyleScript
			when: ToHoveredSkinEvent
			write: (ToFeatureProperty new name: #background)
			with: Color red
			animation: ToPropertyColorTransitionAnimation new ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: wasHere.
	self assert: styleRule skinEventListeners size equals: 1.
	writer := styleRule skinEventListeners first.
	self deny: writer supplement.
	self assert: writer eventClass identicalTo: ToHoveredSkinEvent.
	self assert: (writer property isKindOf: ToFeatureProperty).
	self assert:
		(writer animation isKindOf: ToPropertyColorTransitionAnimation)
]

{ #category : #tests }
ToStyleScriptTest >> testWithChild [

	| selector rhs |
	rhs := ToIdSelector new id: #'button-label'.
	selector := ToStyleScript new withChild: rhs.
	self assert: (selector isKindOf: ToChildSelector ).
	self assert: (selector left isKindOf: ToUniversalSelector).
	self assert: selector right identicalTo: rhs.
	self assert: selector depth isNil
]

{ #category : #tests }
ToStyleScriptTest >> testWithChildAtDepth [

	| selector rhs |
	rhs := ToIdSelector new id: #'button-label'.
	selector := ToStyleScript new withChild: rhs atDepth: 2.
	self assert: (selector isKindOf: ToChildSelector ).
	self assert: (selector left isKindOf: ToUniversalSelector).
	self assert: selector right identicalTo: rhs.
	self assert: selector depth equals: 2
]

{ #category : #tests }
ToStyleScriptTest >> testWithParent [

	| selector rhs |
	rhs := ToIdSelector new id: #'button'.
	selector := ToStyleScript new withParent: rhs.
	self assert: (selector isKindOf: ToParentSelector ).
	self assert: (selector left isKindOf: ToUniversalSelector).
	self assert: selector right identicalTo: rhs.
	self assert: selector depth isNil
]

{ #category : #tests }
ToStyleScriptTest >> testWithParentAtDepth [

	| selector rhs |
	rhs := ToIdSelector new id: #'button'.
	selector := ToStyleScript new withParent: rhs atDepth: 2.
	self assert: (selector isKindOf: ToParentSelector ).
	self assert: (selector left isKindOf: ToUniversalSelector).
	self assert: selector right identicalTo: rhs.
	self assert: selector depth equals: 2
]

{ #category : #tests }
ToStyleScriptTest >> testWriteWith [

	| styleScript styleRule wasHere writer |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleScript select: #button style: [ :theStyleScript |
		wasHere := true.
		theStyleScript
			write: (ToFeatureProperty new name: #size)
			with: 40 asPoint ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: wasHere.
	self assert: styleRule skinEventListeners size equals: 1.
	writer := styleRule skinEventListeners first.
	self deny: writer supplement.
	self assert: writer eventClass equals: ToInstallSkinEvent.
	self assert: (writer property isKindOf: ToFeatureProperty).
	self assert: writer property name equals: #size.
	self assert: writer value equals: 40 asPoint
]

{ #category : #tests }
ToStyleScriptTest >> testWriteWith2 [

	| styleScript styleRule wasHere writer |
	styleScript := ToStyleScript new.
	wasHere := false.
	styleScript select: #button style: [ :theStyleScript |
		wasHere := true.
		theStyleScript
			write: (ToFeatureProperty new name: #size)
			with: [ :e | 40 asPoint ] ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: wasHere.
	self assert: styleRule skinEventListeners size equals: 1.
	writer := styleRule skinEventListeners first.
	self deny: writer supplement.
	self assert: (writer property isKindOf: ToFeatureProperty).
	self assert: writer property name equals: #size.
	self assert: (writer value isKindOf: BlockClosure).
	self assert: writer eventClass identicalTo: ToInstallSkinEvent
]

{ #category : #tests }
ToStyleScriptTest >> testWriteWith3 [

	| styleScript styleRule dangerRule dangerWriter |
	styleScript := ToStyleScript new.
	styleScript select: #button asStampSelector style: [ :theStyleScript |
		theStyleScript
			write: (ToFeatureProperty new name: #border)
			with: Color black.
		theStyleScript
			write: (ToFeatureProperty new name: #background)
			with: Color gray.
		theStyleScript select: #danger asStampSelector style: [
			theStyleScript
				write: (ToFeatureProperty new name: #border)
				with: Color red ] ].
	self assert: styleScript styleRules size equals: 1.
	styleRule := styleScript styleRules first.
	self assert: styleRule skinEventListeners size equals: 2.
	self
		assert: styleRule skinEventListeners first eventClass
		identicalTo: ToInstallSkinEvent.
	self
		assert: styleRule skinEventListeners second eventClass
		identicalTo: ToInstallSkinEvent.

	self assert: styleRule styleRules size equals: 1.
	dangerRule := styleRule styleRules first.
	self assert: (dangerRule selector isKindOf: ToStampSelector).
	self assert: dangerRule skinEventListeners size equals: 1.
	dangerWriter := dangerRule skinEventListeners first.
	self deny: dangerWriter supplement.
	self assert: dangerWriter eventClass identicalTo: ToInstallSkinEvent.
	self assert: (dangerWriter property isKindOf: ToFeatureProperty).
	self assert: dangerWriter property name equals: #border.
	self assert: dangerWriter value equals: Color red
]
