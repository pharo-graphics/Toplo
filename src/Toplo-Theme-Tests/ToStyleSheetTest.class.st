"
A ToStyleSheetTest is a test class for testing the behavior of ToStyleSheet
"
Class {
	#name : #ToStyleSheetTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

{ #category : #tests }
ToStyleSheetTest >> testButtonLabelSkin0 [

	| ss button labelSkin attributes foregroundAttr prop writers label ssi |
	" declare a local only stylesheet "
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToSkinBuilder new.

	" danger button label rule "
	prop := ToPseudoProperty new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes:
			(BlTextAttributesBuilder new foreground: v) attributes.
		e textChanged ].

	ss addStyleRule: (
		((ToStyleStampSelector new addStampName: #'button-label') 
			parent: (ToStyleStampSelector new addAllStampNames: #( #button #danger ))
			depth: 2)
			 style: [ :sr |
				 sr write: prop with: [ :e | (e stampValue: #'color-error') ].
				 sr
					 when: ToDisabledLookEvent
					 write: prop
					 with: [ :e | e stampValue: #'color-text-disabled' ].
				 sr
					 when: ToInitialLookEvent
					 write: prop
					 with: [ :e | (e stampValue: #'color-error') ].
				 sr
					 when: ToHoveredLookEvent
					 write: prop
					 with: [ :e | (e stampValue: #'color-error-hover') ].
				 sr
					 when: ToPressedLookEvent
					 write: prop
					 with: [ :e | (e stampValue: #'color-error-pressed') ] ]).

	button := ToButton new.
	button styleSheet: ss.
	label := (ToLabel text: 'Default') defaultSkin: nil.
	button label: label.
	labelSkin := ToSkin new.
	self assert: (button localStyleStampIndex includes: #danger) not.
	self assert: (button label localStyleStampIndex includesKey: #'button-label').
	writers := ssi writersFor: button label.
	" writers should be empty since the label rule expect the button 
	to be of class #danger and the label to be with style class #'button-label'"
	self assert: writers isEmpty.
	button stampWithAll: #( #button #danger ).
	writers := ssi writersFor: button label.
	self assert: writers size equals: 5.

	labelSkin writers: writers.
	button label withSkin: labelSkin.
	button label checkSkinInstallation.
	attributes := button label text attributesAt: 1.
	self assert: attributes notEmpty.
	foregroundAttr := attributes
		                  detect: [ :eachAttribute |
		                  eachAttribute isKindOf: BlTextForegroundAttribute ]
		                  ifNone: [
			                  self fail:
				                  'should have a foreground attribute (toTheme colorError)' ].
	self
		assert: foregroundAttr paint
		equals: (button stampValue: #'color-error')
]

{ #category : #tests }
ToStyleSheetTest >> testButtonSkin0 [

	| ss button skin labelSkin attributes foregroundAttr writers label ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToSkinBuilder new.
	
	" default button rule "
	ss addStyleRule: ((ToStyleStampSelector new addStampName: #button)
			 style: [ :sr |
				 | p |
				 p := ToFeatureProperty new name: #background.

				 sr
					 when: ToDisabledLookEvent
					 write: p
					 with: [ :e | e stampValue: #'color-bg-container-disabled' ].
				 sr
					 when: ToInitialLookEvent
					 write: p
					 with: [ :e | Color transparent ].

				 p := ToFeatureProperty new name: #border.

				 sr
					 when: ToDisabledLookEvent
					 write: p
					 with: [ :e | (e stampValue: #'color-border-disabled') ].
				 sr
					 when: ToInitialLookEvent
					 write: p
					 with: [ :e | e stampValue: #'color-border' ].
				 sr
					 when: ToHoveredLookEvent
					 write: p
					 with: [ :e | (e stampValue: #'color-primary-hover') ].
				 sr
					 when: ToPressedLookEvent
					 write: p
					 with: [ :e | (e stampValue: #'color-primary-pressed') ] ]).

	" danger button label rule "
	ss addStyleRule: (((ToStyleStampSelector new addStampName: #'button-label')
					  parent:
					  (ToStyleStampSelector new addAllStampNames: #( #button #danger ))
					  depth: 2)
			 style: [ :sr |
				 | p |
				 p := ToPseudoProperty new name: #'text-attributes'.
				 p writer: [ :e :v |
					 e text attributes:
						 (BlTextAttributesBuilder new foreground: v) attributes.
					 e textChanged ].

				 sr
					 when: ToDisabledLookEvent
					 write: p
					 with: [ :e | e stampValue: #'color-text-disabled' ].
				 sr
					 when: ToInitialLookEvent
					 write: p
					 with: [ :e | (e stampValue: #'color-error') ].
				 sr
					 when: ToHoveredLookEvent
					 write: p
					 with: [ :e | (e stampValue: #'color-error-hover') ].
				 sr
					 when: ToPressedLookEvent
					 write: p
					 with: [ :e | (e stampValue: #'color-error-pressed') ] ]).


	button := ToButton new.
	button styleSheet: ss.
	writers := ssi writersFor: button.
	self assert: writers size equals: 6.
	skin := ToSkin new.
	skin writers: writers.
	button withSkin: nil.
	button innerElement defaultSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button checkSkinInstallation.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self
		assert: button border paint color
		equals: (button stampValue: #'color-border').

	label := ToLabel text: 'Default'.
	label defaultSkin: nil.
	label withSkin: nil.
	button label: label.
	labelSkin := ToSkin new.
	writers := ssi writersFor: button label.
	self assert: writers isEmpty.
	button label stampWith: #'button-label'.
	writers := ssi writersFor: button label.
	" should be empty since the label rule expect the button to be of class #danger "
	self assert: writers isEmpty.
	button stampWithAll: #( #button #danger ).
	writers := ssi writersFor: button label.
	self assert: writers size equals: 4.

	labelSkin writers: writers.
	label withSkin: labelSkin.
	label checkSkinInstallation.
	attributes := button label text attributesAt: 1.
	self assert: attributes notEmpty.
	foregroundAttr := attributes
		                  detect: [ :eachAttribute |
		                  eachAttribute isKindOf: BlTextForegroundAttribute ]
		                  ifNone: [
			                  self fail:
				                  'should have a foreground attribute (toTheme colorError)' ].
	self
		assert: foregroundAttr paint
		equals: (button label stampValue: #'color-error')
]

{ #category : #tests }
ToStyleSheetTest >> testButtonSkinWithInterspace [

	| ss elem writers skin interspaceProp layoutProp ssi |
	
	ssi := ToSkinBuilder new.
	interspaceProp := ToPseudoProperty
			   name: #'layout-interspace'
			   reader: [ :e | e layout interspace ]
			   writer: [ :e :v | e layout interspace: v ].
	layoutProp := ToFeatureProperty name: #layout.
	
	ss := ToStyleSheet new inherits: false; yourself.
	ss addStyleRule: (((ToStyleStampSelector new addStampName: #button) 
				or: (ToStyleStampSelector new addAllStampNames: #( #button #horizontal )))
			 style: [ :sr |
				 sr
					 write: layoutProp
					 with: BlLinearLayout horizontal.
				 sr  write: interspaceProp with: 10]).

	elem := ToElement new.
	elem styleSheet: ss.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	elem stampWith: #button.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 2.
	skin := ToSkin new.
	skin writers: writers.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: (elem layout isKindOf: BlLinearLayout).
	self assert: elem layout interspace equals: 10
]

{ #category : #tests }
ToStyleSheetTest >> testEmptyStyleSheet [

	| ss ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToSkinBuilder new.
	self assert: (ssi writersFor: (ToElement new)) isEmpty
]

{ #category : #tests }
ToStyleSheetTest >> testNewStyleSheetWith2Rules [

	| styleSheet elem |
	styleSheet := ToStyleSheet new inherits: false; yourself.
	elem := ToElement new.
	elem styleSheet: styleSheet.
	styleSheet addAllStyleRules: {
			((ToStyleStampSelector new addStampName: #button)
				 style: [ :sr |
					 sr
						 write: (styleSheet writablePropertyNamed: #background)
						 with: Color blue.
					 sr
						 write: (styleSheet writablePropertyNamed: #border)
						 with: Color red ]).
			".button {
				background: blue;
				border: red;
			}"
			((ToStyleStampSelector new addStampName: #button)
				 style: [ :sr |
					 sr
						 write: (styleSheet writablePropertyNamed: #background)
						 with: Color transparent.
					 sr
						 write: (styleSheet writablePropertyNamed: #border)
						 with: Color blue ])
			".button:initial {
				background: transparent;
				border: blue;
			}" }
]

{ #category : #tests }
ToStyleSheetTest >> testSkinWithAnUniversalRule [

	| ss elem skin writers ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToSkinBuilder new.
	ss addStyleRule:
		(ToUniversalSelector new style: [ :sr |
			 sr
				 when: ToInitialLookEvent
				 write: (ToFeatureProperty new name: #background)
				 with: Color red ]).
	elem := ToElement new.
	elem styleSheet: ss.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem background paint color equals: Color red
]

{ #category : #tests }
ToStyleSheetTest >> testSkinWithChildRule [
	" with a direct child "

	| ss skin parent child writers ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToSkinBuilder new.
	ss addStyleRule: (((ToIdSelector new id: #child) parent:
					  (ToStyleStampSelector new addStampName: #parent))
			 style: [ :sr |
				 sr
					 when: ToInitialLookEvent
					 write: (ToFeatureProperty new name: #border)
					 with: (BlBorder paint: Color red width: 3) ]).

	parent := ToElement new stampWith: #parent.
	parent styleSheet: ss.
	child := ToElement new id: #child.
	writers := ssi writersFor: child.
	self assert: writers size equals: 0.

	parent addChild: child.
	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #tests }
ToStyleSheetTest >> testSkinWithChildRuleLevel2 [
	" with a direct child "

	| ss skin parent child writers subParent ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToSkinBuilder new.
	ss addStyleRule: (((ToIdSelector new id: #child)
					  parent: (ToStyleStampSelector new addStampName: #parent)
					  depth: 2)
			 style: [ :sr |
				 sr
					 when: ToInitialLookEvent
					 write: (ToFeatureProperty new name: #border)
					 with: (BlBorder paint: Color red width: 3) ]).

	parent := ToElement new stampWith: #parent.
	parent styleSheet: ss.
	subParent := ToElement new.
	child := ToElement new id: #child.
	writers := ssi writersFor: child.
	self assert: writers size equals: 0.

	parent addChild: subParent.
	subParent addChild: child.
	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #tests }
ToStyleSheetTest >> testSkinWithIdRule [

	| ss elem writers skin ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToSkinBuilder new.
	ss addStyleRule:
		((ToIdSelector new id: #a) style: [ :sr |
			 sr
				 write: (ToFeatureProperty new name: #border)
				 with: (BlBorder paint: Color red width: 3) ]).
	elem := ToElement new.
	elem styleSheet: ss.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	elem id: #a.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem border width equals: 3.
	self assert: elem border paint isColorPaint.
	self assert: elem border paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyle0 [

	| ss button skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.
	button := ToElement new.
	button styleSheet: ss.

	" default button rule "
	rules := { (#button asStyleSelector style: [ :sr |
		          sr write: (ss property: #background) with: Color white.
		          sr
			          when: ToInitialLookEvent
			          write: (ss property: #background)
			          with: [ :e | Color black ].
		          sr
			          when: ToDisabledLookEvent
			          write: (ss property: #background)
			          with: [ :e | e stampValue: #'color-bg-container-disabled' ] ]) }.

	ss addAllStyleRules: rules.
	button stampWith: #button.
	writers := ssi writersFor: button.
	self assert: writers size equals: 3.
	skin := ToSkin new.
	skin writers: writers.
	button withSkin: skin.

	button switchToSkinState: ToInstallState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color white.

	button switchToSkinState: ToInitialState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color black
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithSubRules0 [

	| ss button skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.
	button := ToElement new.
	button styleSheet: ss.

	" default button rule "
	rules := { (#button asStyleSelector style: [ :sr | 
		          sr select: #danger asStyleSelector style: [ 
			          sr write: (ss property: #background) with: Color red.
			          sr
				          when: ToDisabledLookEvent
				          write: (ss property: #background)
				          with: [ :e | Color red alpha: 0.1 ] ].
		          sr write: (ss property: #background) with: Color white.
		          sr
			          when: ToInitialLookEvent
			          write: (ss property: #background)
			          with: [ :e | Color black ].
		          sr
			          when: ToDisabledLookEvent
			          write: (ss property: #background)
			          with: [ :e | Color lightGray ] ]) }.

	ss addAllStyleRules: rules.
	button stampWith: #button.
	writers := ssi writersFor: button.
	self assert: writers size equals: 3.
	skin := ToSkin new.
	skin writers: writers.
	button withSkin: skin.

	button switchToSkinState: ToInstallState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color white.

	button switchToSkinState: ToInitialState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color black.

	button stampWith: #danger.
	button updateSkin.
	button switchToSkinState: ToInstallState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color red.

	button switchToSkinState: ToInitialState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color black.

	button switchToSkinState: ToDisabledState new.
	self assert: button background paint isColorPaint.
	self
		assert: button background paint color
		equals: (Color red alpha: 0.1)
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithSubRules1 [

	| ss elem child childchild1 childchild2 skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.

	elem := ToElement new stampWith: #elem.
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	child styleSheet: ss.
	" default button rule "
	rules := { (#child asStyleSelector style: [ :sr |
		          sr select: sr any style: [
			          sr
				          write: (ss property: #background)
				          with: [ :e | Color red ] ] ]) }.
	ss addAllStyleRules: rules.

	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.

	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1 .
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1.
	self assert: writers size equals: 0.
	
	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithSubRules2 [

	| ss elem child childchild1 childchild2 skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.


	elem := ToElement new stampWith: #elem.
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	elem styleSheet: ss.
	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.
	
		" default button rule "
	rules := { ((#child asStyleSelector parent: #elem) style: [ :sr |
		          sr any style: [
			          sr
				          write: (ss property: #background)
				          with: [ :e | Color red ] ] ]) }.

	ss addAllStyleRules: rules.

	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1 .
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1.
	self assert: writers size equals: 0.

	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithSubRules22 [

	| ss elem child childchild1 childchild2 skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.

	elem := ToElement new stampWithAll: #( elem #red ).
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	elem styleSheet: ss.
	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.

	" default button rule "
	rules := { ((#child asStyleSelector parent: #elem) style: [ :sr |
		          sr
			          select: (sr parent: #red)
			          style: [
			          sr
				          write: (ss property: #background)
				          with: [ :e | Color red ] ] ]) }.

	ss addAllStyleRules: rules.

	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1.
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1.
	self assert: writers size equals: 0.

	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithSubRules3 [

	| ss elem child childchild1 childchild2 skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.


	elem := ToElement new stampWithAll: #( elem #red ).
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	elem styleSheet: ss.
	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.

	" default button rule "
	rules := { ((#child asStyleSelector parent:
		           ((#( #elem #red ) asStyleSelector
			             child: #childchild1
			             depth: 2) child: #childchild2 depth: 2)) style: [ :sr |
		          sr
			          write: (ss property: #background)
			          with: [ :e | Color red ] ]) }.

	ss addAllStyleRules: rules.

	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1 .
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1.
	self assert: writers size equals: 0.

	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithSubRules32 [

	| ss elem child childchild1 childchild2 skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.


	elem := ToElement new stampWithAll: #( elem #red ).
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	elem styleSheet: ss.
	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.

	rules := { ((#child asStyleSelector parent: #elem) style: [ :sr |
		          sr
			          select: (((sr parent: #red) child: #childchild1 depth: 1) child: #childchild2 depth: 1)
			          style: [
			          sr
				          write: (ss property: #background)
				          with: [ :e | Color red ] ] ]) }.
		
	"rules := { ((#child asStyleSelector parent:
		           ((#( #elem #red ) asStyleSelector
			             child: #childchild1
			             depth: 2) child: #childchild2 depth: 2)) style: [ :sr |
		          sr
			          write: (ss property: #background)
			          with: [ :e | Color red ] ]) }."

	ss addAllStyleRules: rules.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1 .
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1.
	self assert: writers size equals: 0.

	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithSubRules33 [

	| ss elem child childchild1 childchild2 skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.


	elem := ToElement new stampWithAll: #( elem #red ).
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	elem styleSheet: ss.
	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.

	rules := { ((#child asStyleSelector parent: #elem) style: [ :sr |
		          ((sr parent: #red) child: #childchild1 depth: 1) style: [
			          (sr child: #childchild2 depth: 1) style: [
				          sr
					          write: (ss property: #background)
					          with: [ :e | Color red ] ] ] ]) }.

	ss addAllStyleRules: rules.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1.
	self assert: writers size equals: 0.
	writers := ssi writersFor: childchild1.
	self assert: writers size equals: 0.

	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithoutSubRules1 [

	| ss elem child childchild1 childchild2 skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.


	elem := ToElement new stampWith: #elem.
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	elem styleSheet: ss.
	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.
	
	" default button rule "
	rules := { (#child asStyleSelector style: [ :sr |
		          sr
			          write: (ss property: #background)
			          with: [ :e | Color red ] ]) }.

	ss addAllStyleRules: rules.
	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithoutSubRules2 [

	| ss elem child childchild1 childchild2 skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.


	elem := ToElement new stampWith: #elem.
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	elem styleSheet: ss.
	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.

	" default button rule "
	rules := { ((#child asStyleSelector parent: #elem) style: [ :sr |
		          sr
			          write: (ss property: #background)
			          with: [ :e | Color red ] ]) }.

	ss addAllStyleRules: rules.

	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithoutSubRules3 [

	| ss elem child childchild1 childchild2 skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.


	elem := ToElement new stampWithAll: #( elem #red ).
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	elem styleSheet: ss.
	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.

	" default button rule "
	rules := { ((#child asStyleSelector parent:
		           ((#( #elem #red ) asStyleSelector
			             child: #childchild1
			             depth: 2) child: #childchild2 depth: 2)) style: [ :sr |
		          sr
			          write: (ss property: #background)
			          with: [ :e | Color red ] ]) }.

	ss addAllStyleRules: rules.

	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithoutSubRules4 [

	| ss elem child childchild1 childchild2 writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToSkinBuilder new.

	elem := ToElement new stampWithAll: #( #elem #red ).
	child := ToElement new stampWith: #child.
	childchild1 := ToElement new stampWith: #childchild1.
	childchild2 := ToElement new stampWith: #childchild2.

	elem styleSheet: ss.
	elem addChild: child.
	child addChild: childchild1.
	child addChild: childchild2.

	" default button rule "
	rules := {
		         ((#child asStyleSelector parent:
			           ((#( #elem #red ) asStyleSelector
				             child: #childchild1
				             depth: 2) child: #childchild2 depth: 2)) style: [ :sr |
			          sr
				          write: (ss property: #background)
				          with: [ :e | Color red ] ]).
			
		         ((#child asStyleSelector parent:
			           ((#( #elem #blue ) asStyleSelector
				             child: #childchild1
				             depth: 2) child: #childchild2 depth: 2)) style: [ :sr |
			          sr
				          write: (ss property: #background)
				          with: [ :e | Color blue ] ]) }.

	ss addAllStyleRules: rules.
	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	child updateSkin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color red.
	
	elem stampWithAll: #( #elem #blue ).
	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	child updateSkin.

	child switchToSkinState: ToInstallState new.
	self assert: child background paint isColorPaint.
	self assert: child background paint color equals: Color blue.
	
]
