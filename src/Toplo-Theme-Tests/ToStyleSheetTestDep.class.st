"
A ToStyleSheetTest is a test class for testing the behavior of ToStyleSheet
"
Class {
	#name : #ToStyleSheetTestDep,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSheetDep'
}

{ #category : #'button skin building' }
ToStyleSheetTestDep >> testButtonLabelSkin0 [

	| ss button looks labelSkin attributes foregroundAttr prop |
	ss := ToStyleSheet new.

	" danger button label rule "
	prop := ToPseudoProperty new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes: (BlTextAttributesBuilder new foreground: v) attributes.
		e textChanged ].
	ss addRule: (ToStyleRuleDep new
			 selectors: { 
				(((ToStyleClassSelector new styleClasses: #( #button )) and: (ToStyleClassSelector new styleClasses: #( #button #danger )))
					child: (ToStyleClassSelector new styleClass: #'button-label')  level: 2) }
			 looks: { ((ToLookUpdater new property: prop)
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
					  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorError darker ];
					  yourself) }).


	button := ToButton new.
	button labelText: 'Default'.
	button label withSkin: nil.
	labelSkin := ToWidgetSkinDep new.
	looks := ss lookUpdatersFor: button label.
	self assert: looks isEmpty.
	button label styleClass: #'button-label'.
	looks := ss lookUpdatersFor: button label.
	" should be empty since the label rule expect the button to be of class #danger "
	self assert: looks isEmpty.
	button styleClasses: #( #button #danger ).
	looks := ss lookUpdatersFor: button label.
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
ToStyleSheetTestDep >> testButtonSkin0 [

	| ss button looks skin labelSkin attributes foregroundAttr prop |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRuleDep new selectors: { (ToStyleClassSelector new styleClass: #button) } looks: {
				 ((ToLookUpdater new property: (ToFeatureProperty new name: #background))
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  when: ToInitialLookEvent value: [ :e | Color transparent ];
					  yourself).
				 ((ToLookUpdater new property: (ToFeatureProperty new name: #border))
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
	ss addRule: (ToStyleRuleDep new
			 selectors: { ((ToStyleClassSelector new styleClass: #'button-label') parent: (ToStyleClassSelector new styleClasses: #( #button #danger )) level: 2) }
			 looks: { ((ToLookUpdater new property: prop)
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
					  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorError darker ];
					  yourself) }).


	button := ToButton new.
	looks := ss lookUpdatersFor: button.
	self assert: looks size equals: 2.
	skin := ToWidgetSkinDep new.
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

	labelSkin := ToWidgetSkinDep new.
	looks := ss lookUpdatersFor: button label.
	self assert: looks isEmpty.
	button label styleClass: #'button-label'.
	looks := ss lookUpdatersFor: button label.
	" should be empty since the label rule expect the button to be of class #danger "
	self assert: looks isEmpty.
	button styleClasses: #( #button #danger ).
	looks := ss lookUpdatersFor: button label.
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
ToStyleSheetTestDep >> testButtonSkin1 [

	| ss button looks initC prop |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule:
		(ToStyleRuleDep new selectors: { (ToStyleClassSelector new styleClass: #button) } 
			looks: { ((ToLookUpdater new property: (ToFeatureProperty new name: #background))
				  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
				  when: ToInitialLookEvent value: [ :e | Color gray ];
				  yourself) }).
	prop := ToPseudoProperty new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes: (BlTextAttributesBuilder new foreground: v) attributes.
		e textChanged ].
	ss addRule: (ToStyleRuleDep new
			 selectors: { ((ToStyleClassSelector new styleClass: #label) parent: (ToStyleClassSelector new styleClass: #'inner-element') level: 1) }
			 looks: { ((ToLookUpdater new property: prop)
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
					  when: ToInitialLookEvent value: [ :e | initC := e toTheme colorText ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself) }).


	button := ToButton new.
	looks := ss lookUpdatersFor: button.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLookUpdater.

	button labelText: 'Default'.
	looks := ss lookUpdatersFor: button label.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLookUpdater.
	looks first receiveEvent: (ToInitialLookEvent new currentTarget: button label).
	self assert: initC equals: button toTheme colorText
]

{ #category : #'button skin building' }
ToStyleSheetTestDep >> testButtonSkin2 [

	| ss button looks prop |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRuleDep new
			 selectors: { (ToStyleClassSelector new styleClass: #button) }
			 looks: { ((ToLookUpdater new property: (ToFeatureProperty new name: #background))
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
				  when: ToInitialLookEvent value: [ :e | Color gray ];
					  yourself) }).

		prop := ToPseudoProperty new name: #'text-attributes'.
		prop writer: [ :e :v |
		e text attributes: (BlTextAttributesBuilder new foreground: v) attributes.
		e textChanged ].	
		ss addRule: (ToStyleRuleDep new
			 selectors: { ((ToStyleClassSelector new styleClass: #label)
					  parent: (ToStyleClassSelector new styleClass: #button)
					  level: 2) }
			 looks: { (ToLookUpdater new property: prop)
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
					  when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).


	button := ToButton new.
	looks := ss lookUpdatersFor: button.
	self assert: looks size equals: 1.
	button labelText: 'Default'.
	looks := ss lookUpdatersFor: button label.
	self assert: looks size equals: 1.

]

{ #category : #'button skin building' }
ToStyleSheetTestDep >> testButtonSkin3 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRuleDep new
			 selectors: { (ToStyleClassSelector new styleClass: #button) }
			 looks: { (ss newLookUpdaterForPropertyName: #background)
				  when: ToInitialLookEvent value: Color gray;
					  yourself }).

	ss addRule: (ToStyleRuleDep new
			 selectors:
			 	{ (ToStyleClassSelector new styleClasses: #( #button )) and: (ToStyleClassSelector new styleClasses: #(#danger )) }
			 looks: { (ss newLookUpdaterForPropertyName: #background)
				  when: ToInitialLookEvent value: Color red;
					  yourself }).

	button := ToButton new.
	looks := ss lookUpdatersFor: button.
	self assert: looks size equals: 1.
	looks first receiveEvent: (ToInitialLookEvent new currentTarget: button).
	self
		assert: button background paint color
		equals: Color gray.
	button addStyleClass: #danger.
	looks := ss lookUpdatersFor: button.
	self assert: looks size equals: 1.
	looks first receiveEvent: (ToInitialLookEvent new currentTarget: button).
	self
		assert: button background paint color
		equals: Color red
]

{ #category : #'button skin building' }
ToStyleSheetTestDep >> testButtonSkin4 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRuleDep new
			 selectors:
			 { (ToStyleClassSelector new styleClasses: #( #button )) and: (ToStyleClassSelector new styleClasses: #(#danger )) }
			 looks: { ((ToLookUpdater new property: (ToFeatureProperty new name: #background)) 
				  when: ToInitialLookEvent value: Color red;
					  yourself) }).

	button := ToButton new.
	looks := ss lookUpdatersFor: button.
	self assert: looks size equals: 0.
	button addStyleClass: #danger.
	looks := ss lookUpdatersFor: button.
	self assert: looks size equals: 1.

]

{ #category : #'button skin building' }
ToStyleSheetTestDep >> testButtonSkin5 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRuleDep new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button )) }
			 looks: { ((ss property: (#background))
				  when: ToInitialLookEvent value: Color red;
					  yourself) }).

	button := ToButton new.
	looks := ss lookUpdatersFor: button.
	self assert: looks size equals: 1.

	button addStyleClass: #danger.
	looks := ss lookUpdatersFor: button.
	self assert: looks size equals: 1
]

{ #category : #basic }
ToStyleSheetTestDep >> testEmptyStyleSheet [

	| ss |
	ss := ToStyleSheet new.
	self assert: (ss rulesFor: (ToElement new)) isEmpty
]

{ #category : #'skin building' }
ToStyleSheetTestDep >> testSkinWithAnUniversalRule [

	| ss elem looks skin |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRuleDep new
			 selectors: { ToUniversalSelector new }
			 looks: { ((ToLookUpdater new property: (ToFeatureProperty new name: #background))
				  when: ToInitialLookEvent value: Color red;
					  yourself) }).
	elem := ToElement new.
	looks := ss lookUpdatersFor: elem.
	self assert: looks size equals: 1.
	skin := ToWidgetSkinDep new.
	skin addAllLookUpdaters: looks.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem background paint color equals: Color red
]

{ #category : #'skin building' }
ToStyleSheetTestDep >> testSkinWithChildRule [

	" with a direct child "
	| ss looks skin parent child |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRuleDep new
			 selectors: { ((ToIdSelector new id: #child) parent:
					  (ToStyleClassSelector new styleClass: #parent)) }
			 looks: { ((ToLookUpdater new property: (ToFeatureProperty new name: #border))
				  when: ToInitialLookEvent value: (BlBorder paint: Color red width: 3);
					  yourself) }).
	parent := ToElement new styleClass: #parent.
	child := ToElement new id: #child.
	looks := ss lookUpdatersFor: child.
	self assert: looks size equals: 0.

	parent addChild: child.
	looks := ss lookUpdatersFor: child.
	self assert: looks size equals: 1.
	skin := ToWidgetSkinDep new.
	skin addAllLookUpdaters: looks.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #'skin building' }
ToStyleSheetTestDep >> testSkinWithChildRule2 [

	" the child is not a direct child "
	| ss looks skin parent child subParent |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRuleDep new
			 selectors: { ((ToIdSelector new id: #child) parent:
					  (ToStyleClassSelector new styleClass: #parent) level: 2) }
			 looks: { ((ToLookUpdater new property: (ToFeatureProperty new name: #border))
				  when: ToInitialLookEvent value: (BlBorder paint: Color red width: 3);
					  yourself) }).
	parent := ToElement new styleClass: #parent.
	subParent := ToElement new.
	child := ToElement new id: #child.
	looks := ss lookUpdatersFor: child.
	self assert: looks size equals: 0.

	parent addChild: subParent.
	subParent addChild: child.
	looks := ss lookUpdatersFor: child.
	self assert: looks size equals: 1.
	skin := ToWidgetSkinDep new.
	skin addAllLookUpdaters: looks.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #'skin building' }
ToStyleSheetTestDep >> testSkinWithIdRule [

	| ss elem looks skin |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRuleDep new
			 selectors: { (ToIdSelector new id: #a) }
			 looks: { ((ToLookUpdater new property: (ToFeatureProperty new name: #border))
				  when: ToInitialLookEvent value: (BlBorder paint: Color red width: 3);
					  yourself) }).
	elem := ToElement new.
	looks := ss lookUpdatersFor: elem.
	self assert: looks size equals: 0.
	elem id: #a.
	looks := ss lookUpdatersFor: elem.
	self assert: looks size equals: 1.
	skin := ToWidgetSkinDep new.
	skin addAllLookUpdaters: looks.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem border width equals: 3.
	self assert: elem border paint isColorPaint.
	self assert: elem border paint color equals: Color red
]

{ #category : #basic }
ToStyleSheetTestDep >> testStyleSheetWithAnUniversalRule [

	| ss |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRuleDep new selectors: { (ToUniversalSelector new) } looks: { }).
	self assert: (ss rulesFor: (ToElement new)) size equals: 1
]
