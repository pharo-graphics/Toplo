Class {
	#name : #ToDefaultStyleSheet,
	#superclass : #ToStyleSheet,
	#category : #'Toplo-Theme-DefaultTheme'
}

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addButtonRules [
	" no border for #text and #link ( which elementClass includes #'no-border' ) "

	self addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses:
				  #( #button #'no-border' )) }
			 looks: { ToBorderLook new }).

	" no background for #link ( which elementClass includes #'no-background' ) "
	self addRule: (ToStyleRule new
			 selectors: { (ToClassSelector new elementClasses:
					  #( #button #'no-background' )) }
			 looks: { ToBackgroundLook new }).

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
			 selectors: { (ToClassSelector new elementClass: #button) }
			 looks: {
					 (ToBackgroundLook new
						  disabledStateValue: [ :e | e toTheme colorBgContainerDisabled ];
						  initialStateValue: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  initialPaint: [ :e | e toTheme colorBorder ];
						  hoverPaint: [ :e | e toTheme colorPrimaryHover ];
						  pressedPaint: [ :e | e toTheme colorPrimaryPressed ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) }).

	" default button form icon "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #'form-icon')
					  parent: (ToClassSelector new elementClass: #button)
					  level: 2) }
			 looks: { (ToMonoColorFlatImageFormLook new
					  disabledColor: [ :e | e toTheme colorImageDisabled ];
					  initialColor: [ :e | e toTheme colorText ];
					  hoverColor: [ :e | e toTheme colorPrimary ];
					  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
					  yourself) }).

	" default button label "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #label)
					  parent: (ToClassSelector new elementClass: #button)
					  level: 2) }
			 looks: { (ToLabelTextLook new
					  disabledColor: [ :e | e toTheme colorTextDisabled ];
					  initialColor: [ :e | e toTheme colorText ];
					  hoverColor: [ :e | e toTheme colorPrimary ];
					  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
					  yourself) }).

	" default button dashed "
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses: #( #button #dashed )) }
			 looks: {
					 (ToBackgroundLook new
						  disabledStateValue: [ :e | e toTheme colorBgContainerDisabled ];
						  initialStateValue: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  initialPaint: [ :e | e toTheme colorBorder ];
						  hoverPaint: [ :e | e toTheme colorPrimaryHover ];
						  pressedPaint: [ :e | e toTheme colorPrimaryPressed ];
						  dashArray: [ :e | e toTheme dashArray ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) }).

	" ToButton default danger"
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses: #( #button #danger )) }
			 looks: {
					 (ToBackgroundLook new
						  disabledStateValue: [ :e | e toTheme colorBgContainerDisabled ];
						  initialStateValue: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  initialPaint: [ :e | e toTheme colorError ];
						  hoverPaint: [ :e | e toTheme colorErrorHover ];
						  pressedPaint: [ :e | e toTheme colorErrorHover darker ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) }).

	" ToButton default danger dashed"
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses:
				  #( #button #danger #dashed )) }
			 looks: {
					 (ToBackgroundLook new
						  disabledStateValue: [ :e | e toTheme colorBgContainerDisabled ];
						  initialStateValue: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  initialPaint: [ :e | e toTheme colorError ];
						  hoverPaint: [ :e | e toTheme colorErrorHover ];
						  dashArray: [ :e | e toTheme dashArray ];
						  pressedPaint: [ :e | e toTheme colorErrorHover darker ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) }).

	" danger button form icon "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #'form-icon')
					  parent:
					  (ToClassSelector new elementClasses: #( #button #danger ))
					  level: 2) }
			 looks: { (ToMonoColorFlatImageFormLook new
					  disabledColor: [ :e | e toTheme colorImageDisabled ];
					  initialColor: [ :e | e toTheme colorError ];
					  hoverColor: [ :e | e toTheme colorErrorHover ];
					  pressedColor: [ :e | e toTheme colorError darker ];
					  yourself) }).

	" danger button label "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #label)
					  parent:
					  (ToClassSelector new elementClasses: #( #button #danger ))
					  level: 2) }
			 looks: { (ToLabelTextLook new
					  disabledColor: [ :e | e toTheme colorTextDisabled ];
					  initialColor: [ :e | e toTheme colorError ];
					  hoverColor: [ :e | e toTheme colorErrorHover ];
					  pressedColor: [ :e | e toTheme colorError darker ];
					  yourself) })
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addLinkButtonRules [
	" ToButton link "


]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addPrimaryButtonRules [
	" ToButton primary "

	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  (ToClassSelector new elementClass: #primary)) }
			 looks: {
					 (ToBackgroundLook new
						  initialStateValue: [ :e | e toTheme colorPrimary ];
						  disabledStateValue: [ :e | e toTheme colorBgContainerDisabled ];
						  pressedStateValue: ([ :e | e toTheme colorPrimaryPressed ] asStateValue duration: 200 milliSeconds);
						  hoverStateValue: ([ :e | e toTheme colorPrimaryHover ] asStateValue duration: 200 milliSeconds);
						  yourself).
					 (ToBorderLook new
						  initialPaint: [ :e | Color transparent ];
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) }).

	" ToButton primary danger "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  ((ToClassSelector new elementClass: #primary) and:
						   (ToClassSelector new elementClass: #danger))) }
			 looks: {
					 (ToBackgroundLook new
						  initialStateValue: [ :e | e toTheme colorError ];
						  disabledStateValue: [ :e | e toTheme colorBgContainerDisabled ];
						  pressedStateValue: ([ :e | e toTheme colorErrorPressed ] asStateValue duration: 200 milliSeconds);
						  hoverStateValue: ([ :e | e toTheme colorErrorHover ] asStateValue duration: 200 milliSeconds);
						  yourself).
					 (ToBorderLook new
						  initialPaint: [ :e | Color transparent ];
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) })
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addTextButtonRules [
	" ToButton text "

	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  (ToClassSelector new elementClass: #text)) }
			 looks: { (ToBackgroundLook new
					  disabledStateValue: [ :e | e toTheme colorBgContainerDisabled ];
					  initialStateValue: [ :e | Color transparent ];
					  pressedStateValue: [ :e | e toTheme colorBgTextActive ];
					  hoverStateValue: [ :e | e toTheme colorBgTextHover ];
					  yourself) }).

	" ToButton text danger "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  ((ToClassSelector new elementClass: #text) and:
						   (ToClassSelector new elementClass: #danger))) }
			 looks: { (ToBackgroundLook new
					  disabledStateValue: [ :e | e toTheme colorBgContainerDisabled ];
					  initialStateValue: [ :e | Color transparent ];
					  pressedStateValue: [ :e | e toTheme colorErrorBg ];
					  hoverStateValue: [ :e | e toTheme colorErrorBg ];
					  yourself) })
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