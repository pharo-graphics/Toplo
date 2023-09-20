"
A ToStyleSheetTest is a test class for testing the behavior of ToStyleSheet
"
Class {
	#name : 'ToStyleSheetTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Theme-Tests-StyleSheet',
	#package : 'Toplo-Theme-Tests',
	#tag : 'StyleSheet'
}

{ #category : 'tests' }
ToStyleSheetTest >> testButtonLabelSkin0 [

	| ss button labelSkin attributes foregroundAttr prop writers label |
	ss := ToStyleSheet new.

	" danger button label rule "
	prop := ToPseudoProperty new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes:
			(BlTextAttributesBuilder new foreground: v) attributes.
		e textChanged ].

	ss addRule: (
				 ((ToStyleTagSelector new styleTags: #( #button #danger ))
					  child: (ToStyleTagSelector new styleTag: #'button-label')
					  level: 2)
			 style: [ :sr |
				 sr write: prop with: [ :e | e toTheme colorError ].
				 sr
					 when: ToDisabledLookEvent
					 write: prop
					 with: [ :e | e toTheme colorTextDisabled ].
				 sr
					 when: ToInitialLookEvent
					 write: prop
					 with: [ :e | e toTheme colorError ].
				 sr
					 when: ToHoveredLookEvent
					 write: prop
					 with: [ :e | e toTheme colorErrorHover ].
				 sr
					 when: ToPressedLookEvent
					 write: prop
					 with: [ :e | e toTheme colorError darker ] ]).

	button := ToButton new.
	label := (ToLabel text: 'Default') defaultSkin: nil.
	button label: label.
	labelSkin := ToSkin new.
	self assert: (button styleTags includes: #danger) not.
	self assert:
		(button label styleTags includes: #'button-label') not.
	writers := ss writersFor: button label.
	" writers should be empty since the label rule expect the button 
	to be of class #danger and the label to be with style class #'button-label'"
	self assert: writers isEmpty.
	button label styleTag: #'button-label'.
	writers := ss writersFor: button label.
	" writers should be empty since the label rule expect the button to be of class #danger "
	self assert: writers isEmpty.
	button styleTags: #( #button #danger ).
	writers := ss writersFor: button label.
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
		equals: button label toTheme colorError
]

{ #category : 'tests' }
ToStyleSheetTest >> testButtonSkin0 [

	| ss button skin labelSkin attributes foregroundAttr writers label |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: ((ToStyleTagSelector new styleTag: #button)
			 style: [ :sr |
				 | p |
				 p := ToFeatureProperty new name: #background.

				 sr
					 when: ToDisabledLookEvent
					 write: p
					 with: [ :e | e toTheme colorBgContainerDisabled ].
				 sr
					 when: ToInitialLookEvent
					 write: p
					 with: [ :e | Color transparent ].

				 p := ToFeatureProperty new name: #border.

				 sr
					 when: ToDisabledLookEvent
					 write: p
					 with: [ :e | e toTheme colorBorderDisabled ].
				 sr
					 when: ToInitialLookEvent
					 write: p
					 with: [ :e | e toTheme colorBorder ].
				 sr
					 when: ToHoveredLookEvent
					 write: p
					 with: [ :e | e toTheme colorPrimaryHover ].
				 sr
					 when: ToPressedLookEvent
					 write: p
					 with: [ :e | e toTheme colorPrimaryPressed ] ]).

	" danger button label rule "
	ss addRule: (((ToStyleTagSelector new styleTag: #'button-label')
					  parent:
					  (ToStyleTagSelector new styleTags: #( #button #danger ))
					  level: 2)
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
					 with: [ :e | e toTheme colorTextDisabled ].
				 sr
					 when: ToInitialLookEvent
					 write: p
					 with: [ :e | e toTheme colorError ].
				 sr
					 when: ToHoveredLookEvent
					 write: p
					 with: [ :e | e toTheme colorErrorHover ].
				 sr
					 when: ToPressedLookEvent
					 write: p
					 with: [ :e | e toTheme colorError darker ] ]).


	button := ToButton new.
	writers := ss writersFor: button.
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
		equals: button toTheme colorBorder.

	label := ToLabel text: 'Default'.
	label defaultSkin: nil.
	label withSkin: nil.
	button label: label.
	labelSkin := ToSkin new.
	writers := ss writersFor: button label.
	self assert: writers isEmpty.
	button label styleTag: #'button-label'.
	writers := ss writersFor: button label.
	" should be empty since the label rule expect the button to be of class #danger "
	self assert: writers isEmpty.
	button styleTags: #( #button #danger ).
	writers := ss writersFor: button label.
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
		equals: button label toTheme colorError
]

{ #category : 'tests' }
ToStyleSheetTest >> testButtonSkinWithInterspace [

	| ss elem writers skin interspaceProp layoutProp |
	
	interspaceProp := ToPseudoProperty
			   name: #'layout-interspace'
			   reader: [ :e | e layout interspace ]
			   writer: [ :e :v | e layout interspace: v ].
	layoutProp := ToFeatureProperty name: #layout.
	
	ss := ToStyleSheet new.
	ss addRule: (((ToStyleTagSelector new styleTag: #button) 
				or: (ToStyleTagSelector new styleTags: #( #button #horizontal )))
			 when: ToInstallLookEvent
			 style: [ :sr |
				 sr
					 write: layoutProp
					 with: BlLinearLayout horizontal.
				 sr  write: interspaceProp with: 10]).

	elem := ToElement new.
	writers := ss writersFor: elem.
	self assert: writers size equals: 0.
	elem styleTag: #button.
	writers := ss writersFor: elem.
	self assert: writers size equals: 2.
	skin := ToSkin new.
	skin writers: writers.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: (elem layout isKindOf: BlLinearLayout).
	self assert: elem layout interspace equals: 10
]

{ #category : 'tests' }
ToStyleSheetTest >> testEmptyStyleSheet [

	| ss |
	ss := ToStyleSheet new.
	self assert: (ss writersFor: (ToElement new)) isEmpty
]

{ #category : 'tests' }
ToStyleSheetTest >> testNewStyleSheetWith2Rules [

	| styleSheet |
	styleSheet := ToStyleSheet new.
	styleSheet addRules: {
			((ToStyleTagSelector new styleTag: #button)
				 style: [ :sr |
					 sr
						 write: (styleSheet propertyNamed: #background)
						 with: Color blue.
					 sr
						 write: (styleSheet propertyNamed: #border)
						 with: Color red ]).
			".button {
				background: blue;
				border: red;
			}"
			((ToStyleTagSelector new styleTag: #button)
				 when: ToInitialLookEvent
				 style: [ :sr |
					 sr
						 write: (styleSheet propertyNamed: #background)
						 with: Color transparent.
					 sr
						 write: (styleSheet propertyNamed: #border)
						 with: Color blue ])
			".button:initial {
				background: transparent;
				border: blue;
			}" }
]

{ #category : 'tests' }
ToStyleSheetTest >> testSkinWithAnUniversalRule [

	| ss elem skin writers |
	ss := ToStyleSheet new.
	ss addRule:
		(ToUniversalSelector new style: [ :sr |
			 sr
				 when: ToInitialLookEvent
				 write: (ToFeatureProperty new name: #background)
				 with: Color red ]).
	elem := ToElement new.
	writers := ss writersFor: elem.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem background paint color equals: Color red
]

{ #category : 'tests' }
ToStyleSheetTest >> testSkinWithChildRule [
	" with a direct child "

	| ss skin parent child writers |
	ss := ToStyleSheet new.
	ss addRule: (((ToIdSelector new id: #child) parent:
					  (ToStyleTagSelector new styleTag: #parent))
			 style: [ :sr |
				 sr
					 when: ToInitialLookEvent
					 write: (ToFeatureProperty new name: #border)
					 with: (BlBorder paint: Color red width: 3) ]).

	parent := ToElement new styleTag: #parent.
	child := ToElement new id: #child.
	writers := ss writersFor: child.
	self assert: writers size equals: 0.

	parent addChild: child.
	writers := ss writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : 'tests' }
ToStyleSheetTest >> testSkinWithChildRuleLevel2 [
	" with a direct child "

	| ss skin parent child writers subParent |
	ss := ToStyleSheet new.
	ss addRule: (((ToIdSelector new id: #child)
					  parent: (ToStyleTagSelector new styleTag: #parent)
					  level: 2)
			 style: [ :sr |
				 sr
					 when: ToInitialLookEvent
					 write: (ToFeatureProperty new name: #border)
					 with: (BlBorder paint: Color red width: 3) ]).

	parent := ToElement new styleTag: #parent.
	subParent := ToElement new.
	child := ToElement new id: #child.
	writers := ss writersFor: child.
	self assert: writers size equals: 0.

	parent addChild: subParent.
	subParent addChild: child.
	writers := ss writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : 'tests' }
ToStyleSheetTest >> testSkinWithIdRule [

	| ss elem writers skin |
	ss := ToStyleSheet new.
	ss addRule:
		((ToIdSelector new id: #a) when: ToInitialLookEvent style: [ :sr |
			 sr
				 write: (ToFeatureProperty new name: #border)
				 with: (BlBorder paint: Color red width: 3) ]).
	elem := ToElement new.
	writers := ss writersFor: elem.
	self assert: writers size equals: 0.
	elem id: #a.
	writers := ss writersFor: elem.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem border width equals: 3.
	self assert: elem border paint isColorPaint.
	self assert: elem border paint color equals: Color red
]
