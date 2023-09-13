Class {
	#name : #ToDefaultStyleSheet,
	#superclass : #ToStyleSheet,
	#category : #'Toplo-Theme-DefaultTheme'
}

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addButtonRules [
	" no border for #text and #link ( which elementClass includes #'no-border' ) "

	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button #'no-border' )) }
			 looks: { self newLookUpdaterFromPropertyName: #border }).

	" no background for #link ( which elementClass includes #'no-background' ) "
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button #'no-background' )) }
			 looks: { self newLookUpdaterFromPropertyName: #background }).

	self addDefaultButtonRules.
	self addPrimaryButtonRules.
	self addTextButtonRules.
	self addLinkButtonRules
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addDefaultButtonRules [
	" ToButton default rule including icon and label "

	" default button (class #button) "

	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClass: #button) }
			 looks: {
					 (self newLookUpdaterFromPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (self newLookUpdaterFromPropertyName: #border)
						  when: ToInitialLookEvent value: [ :e | e toTheme colorBorder ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
						  yourself }).

	" default button form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #'form-icon')
					parent: (ToStyleClassSelector new styleClass: #button)
					level: 2) }
			 looks:
				 { (self newLookUpdaterFromPropertyName: #'image-inner-form-color')
					  when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).

	" default button label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #label)
					  parent: (ToStyleClassSelector new styleClass: #button)
					  level: 2) }
			 looks: { (self newLookUpdaterFromPropertyName: #'label-text-foreground')
					  when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).

	" default button dashed "
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button #dashed )) }
			 looks: {
					 (self newLookUpdaterFromPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (self newLookUpdaterFromPropertyName: #border)
						  when: ToInitialLookEvent value: [ :e | e toTheme colorBorder ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
						  yourself }).

	" ToButton default danger"
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button #danger )) }
			 looks: {
					 (self newLookUpdaterFromPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (self newLookUpdaterFromPropertyName: #border)
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorHover darker ];
						  yourself }).

	" ToButton default danger dashed"
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button #danger #dashed )) }
			 looks: {
					 (self newLookUpdaterFromPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (self newLookUpdaterFromPropertyName: #border)
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorHover darker ];
						  yourself }).

	" danger button form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #'form-icon')
					  parent: (ToStyleClassSelector new styleClasses: #( #button #danger ))
					  level: 2) } 
			 looks: { 
						(self newLookUpdaterFromPropertyName: #'image-inner-form-color')
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorImageDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorHover darker ];
						  yourself }).

	" danger button label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #label)
					parent: (ToStyleClassSelector new styleClasses: #( #button #danger ))
					level: 2) }
			 looks: { 
						(self newLookUpdaterFromPropertyName: #'label-text-foreground')
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorHover darker ];
					     yourself })
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addLinkButtonRules [
	" ToButton link "


]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addPrimaryButtonRules [
	" ToButton primary "

	self addRule: (ToStyleRule new
			 selectors: { 
					((ToStyleClassSelector new styleClass: #button) and:
					  (ToStyleClassSelector new styleClass: #primary)) }
			 looks: {			
					 (self newLookUpdaterFromPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | e toTheme colorPrimary ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
						  yourself.
					 (self newLookUpdaterFromPropertyName: #border)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  yourself }).

	" ToButton primary danger "
	self addRule: (ToStyleRule new
			 selectors: { 
					((ToStyleClassSelector new styleClass: #button) and:
					  ((ToStyleClassSelector new styleClass: #primary) and:
						 (ToStyleClassSelector new styleClass: #danger))) }
			 looks: {	 
					(self newLookUpdaterFromPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorPressed ];
						  yourself.
					 (self newLookUpdaterFromPropertyName: #border)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  yourself })
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addTextButtonRules [
	" ToButton text "

	self addRule: (ToStyleRule new
			 selectors: { 
					((ToStyleClassSelector new styleClass: #button) and:
					  (ToStyleClassSelector new styleClass: #text)) }
			 looks: { 
					(self newLookUpdaterFromPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorBgTextHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorBgTextActive ];
						  yourself }).

	" ToButton text danger "
	self addRule: (ToStyleRule new
			 selectors: { 
					((ToStyleClassSelector new styleClass: #button) and:
					  ((ToStyleClassSelector new styleClass: #text) and:
						   (ToStyleClassSelector new styleClass: #danger))) }
			 looks: {
					(self newLookUpdaterFromPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorBg ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorBg ];
						  yourself })
]

{ #category : #initialization }
ToDefaultStyleSheet >> initialize [ 

	super initialize.
	self initializeDefaultThemeRules
]

{ #category : #initialization }
ToDefaultStyleSheet >> initializeDefaultThemeRules [
	" * { background-color: #transparent; border-with: 0; border-color: #transparent} "

	"self addRule:
		(ToStyleRule new
			 selectors: { ToUniversalSelector new }
			 looks: {
					 ToBackgroundColorLook new.
					 ToBorderLook new })."

	self addButtonRules
]
