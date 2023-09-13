"
A ToStyleSheetTest is a test class for testing the behavior of ToStyleSheet
"
Class {
	#name : #ToStyleSheetTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin0 [

	| ss button looks skin labelSkin attributes foregroundAttr prop |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new selectors: { (ToStyleClassSelector new elementClass: #button) } looks: {
				 ((ToLookUpdater new property: (ToInstVarProperty new name: #background))
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  when: ToInitialLookEvent value: [ :e | Color transparent ];
					  yourself).
				 ((ToLookUpdater new property: (ToInstVarProperty new name: #border))
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
					  when: ToInitialLookEvent value: [ :e | e toTheme colorBorder ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself) }).

	" danger button label rule "
	prop := ToPseudoProperty new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes: (BlTextAttributesBuilder new foreground: v) attributes.
		e textChanged ].
	ss addRule: (ToStyleRule new
			 selectors: { ((ToStyleClassSelector new elementClass: #'button-label') parent: (ToStyleClassSelector new styleClasses: #( #button #danger )) level: 2) }
			 looks: { ((ToLookUpdater new property: prop)
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
					  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorError darker ];
					  yourself) }).


	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 2.
	skin := ToWidgetSkin new.
	skin addAllLookUpdaters: looks.
	button withSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button checkSkinInstallation.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: button toTheme colorBorder.

	button labelText: 'Default'.
	button label withSkin: nil.

	labelSkin := ToWidgetSkin new.
	looks := ss looksFor: button label.
	self assert: looks isEmpty.
	button label styleClass: #'button-label'.
	looks := ss looksFor: button label.
	" should be empty since the label rule expect the button to be of class #danger "
	self assert: looks isEmpty.
	button styleClasses: #( #button #danger ).
	looks := ss looksFor: button label.
	self assert: looks size equals: 1.

	labelSkin addAllLookUpdaters: looks.
	button label withSkin: labelSkin.
	button label checkSkinInstallation.
	attributes := button label text attributesAt: 1.
	self assert: attributes notEmpty.
	foregroundAttr := attributes
		                  detect: [ :eachAttribute | eachAttribute isKindOf: BlTextForegroundAttribute ]
		                  ifNone: [ self fail: 'should have a foreground attribute (toTheme colorError)' ].
	self assert: foregroundAttr paint equals: button label toTheme colorError
]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin1 [

	| ss button looks initC prop |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule:
		(ToStyleRule new selectors: { (ToStyleClassSelector new elementClass: #button) } 
			looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #background))
				  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
				  when: ToInitialLookEvent value: [ :e | Color gray ];
				  yourself) }).
	prop := ToPseudoProperty new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes: (BlTextAttributesBuilder new foreground: v) attributes.
		e textChanged ].
	ss addRule: (ToStyleRule new
			 selectors: { ((ToStyleClassSelector new elementClass: #label) parent: (ToStyleClassSelector new elementClass: #'triplet-inner-element') level: 1) }
			 looks: { ((ToLookUpdater new property: prop)
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
					  when: ToInitialLookEvent value: [ :e | initC := e toTheme colorText ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself) }).


	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLookUpdater.

	button labelText: 'Default'.
	looks := ss looksFor: button label.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLookUpdater.
	looks first announceLookEvent: (ToInitialLookEvent new currentTarget: button label).
	self assert: initC equals: button toTheme colorText
]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin2 [

	| ss button looks prop |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new elementClass: #button) }
			 looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #background))
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
				  when: ToInitialLookEvent value: [ :e | Color gray ];
					  yourself) }).

		prop := ToPseudoProperty new name: #'text-attributes'.
		prop writer: [ :e :v |
		e text attributes: (BlTextAttributesBuilder new foreground: v) attributes.
		e textChanged ].	
		ss addRule: (ToStyleRule new
			 selectors: { ((ToStyleClassSelector new elementClass: #label)
					  parent: (ToStyleClassSelector new elementClass: #button)
					  level: 2) }
			 looks: { (ToLookUpdater new property: prop)
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
					  when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).


	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	button labelText: 'Default'.
	looks := ss looksFor: button label.
	self assert: looks size equals: 1.

]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin3 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new elementClass: #button) }
			 looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #background))
				  when: ToInitialLookEvent value: Color gray;
					  yourself) }).
	ss addRule: (ToStyleRule new
			 selectors:
			 { (ToStyleClassSelector new styleClasses: #( #button #danger )) }
			 looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #background))
				  when: ToInitialLookEvent value: Color red;
					  yourself) }).

	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	looks first announceLookEvent: (ToInitialLookEvent new currentTarget: button).
	self
		assert: button background paint color
		equals: Color gray.
	button addStyleClass: #danger.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	looks first announceLookEvent: (ToInitialLookEvent new currentTarget: button).
	self
		assert: button background paint color
		equals: Color red
]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin4 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors:
			 { (ToStyleClassSelector new styleClasses: #( #button #danger )) }
			 looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #background))
				  when: ToInitialLookEvent value: Color red;
					  yourself) }).

	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 0.
	button addStyleClass: #danger.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.

]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin5 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button )) }
			 looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #background))
				  when: ToInitialLookEvent value: Color red;
					  yourself) }).

	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.

	button addStyleClass: #danger.
	looks := ss looksFor: button.
	self assert: looks size equals: 0
]

{ #category : #basic }
ToStyleSheetTest >> testEmptyStyleSheet [

	| ss |
	ss := ToStyleSheet new.
	self assert: (ss rulesFor: (ToElement new)) isEmpty
]

{ #category : #'skin building' }
ToStyleSheetTest >> testSkinWithAnUniversalRule [

	| ss elem looks skin |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new
			 selectors: { ToUniversalSelector new }
			 looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #background))
				  when: ToInitialLookEvent value: Color red;
					  yourself) }).
	elem := ToElement new.
	looks := ss looksFor: elem.
	self assert: looks size equals: 1.
	skin := ToWidgetSkin new.
	skin addAllLookUpdaters: looks.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem background paint color equals: Color red
]

{ #category : #'skin building' }
ToStyleSheetTest >> testSkinWithChildRule [

	" with a direct child "
	| ss looks skin parent child |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new
			 selectors: { ((ToIdSelector new id: #child) parent:
					  (ToStyleClassSelector new elementClass: #parent)) }
			 looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #border))
				  when: ToInitialLookEvent value: (BlBorder paint: Color red width: 3);
					  yourself) }).
	parent := ToElement new styleClass: #parent.
	child := ToElement new id: #child.
	looks := ss looksFor: child.
	self assert: looks size equals: 0.

	parent addChild: child.
	looks := ss looksFor: child.
	self assert: looks size equals: 1.
	skin := ToWidgetSkin new.
	skin addAllLookUpdaters: looks.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #'skin building' }
ToStyleSheetTest >> testSkinWithChildRule2 [

	" the child is not a direct child "
	| ss looks skin parent child subParent |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new
			 selectors: { ((ToIdSelector new id: #child) parent:
					  (ToStyleClassSelector new elementClass: #parent) level: 2) }
			 looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #border))
				  when: ToInitialLookEvent value: (BlBorder paint: Color red width: 3);
					  yourself) }).
	parent := ToElement new styleClass: #parent.
	subParent := ToElement new.
	child := ToElement new id: #child.
	looks := ss looksFor: child.
	self assert: looks size equals: 0.

	parent addChild: subParent.
	subParent addChild: child.
	looks := ss looksFor: child.
	self assert: looks size equals: 1.
	skin := ToWidgetSkin new.
	skin addAllLookUpdaters: looks.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #'skin building' }
ToStyleSheetTest >> testSkinWithIdRule [

	| ss elem looks skin |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new
			 selectors: { (ToIdSelector new id: #a) }
			 looks: { ((ToLookUpdater new property: (ToInstVarProperty new name: #border))
				  when: ToInitialLookEvent value: (BlBorder paint: Color red width: 3);
					  yourself) }).
	elem := ToElement new.
	looks := ss looksFor: elem.
	self assert: looks size equals: 0.
	elem id: #a.
	looks := ss looksFor: elem.
	self assert: looks size equals: 1.
	skin := ToWidgetSkin new.
	skin addAllLookUpdaters: looks.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem border width equals: 3.
	self assert: elem border paint isColorPaint.
	self assert: elem border paint color equals: Color red
]

{ #category : #basic }
ToStyleSheetTest >> testStyleSheetWithAnUniversalRule [

	| ss |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new selectors: { (ToUniversalSelector new) } looks: { ToLookDep new }).
	self assert: (ss rulesFor: (ToElement new)) size equals: 1
]
