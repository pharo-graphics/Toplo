Class {
	#name : #ToStyleSheet,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #'Toplo-StyleSheet-Model'
}

{ #category : #'initialization-button' }
ToStyleSheet >> addButtonRules [

	" no border for #text and #link ( which elementClass includes #'no-border' ) "
	self addRule: (ToStyleRule new
			 selectors:
				 { ((ToStyleClassSelector new elementClass: #button) and:
					  (ToStyleClassSelector new elementClasses: #( #'no-border' ))) }
			 looks: { ToBorderLook new }).

	" no background for #link ( which elementClass includes #'no-background' ) "
	self addRule: (ToStyleRule new
			 selectors:
				 { ((ToStyleClassSelector new elementClass: #button) and:
					  (ToStyleClassSelector new elementClasses: #( #'no-background' ))) }
			 looks: { ToBackgroundColorLook new }).

	self addDefaultButtonRules.
	self addPrimaryButtonRules.
	self addTextButtonRules.
	self addLinkButtonRules
]

{ #category : #'initialization-button' }
ToStyleSheet >> addDefaultButtonRules [

	" ToButton default "
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new elementClass: #button) }
			 looks: {
					 (ToBackgroundColorLook new
						  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
						  initialColor: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  initialPaint: [ :e | e toTheme colorBorder ];
						  hoverPaint: [ :e | e toTheme colorPrimaryHover ];
						  pressedPaint: [ :e | e toTheme colorPrimaryPressed ];
						  dashArray: [ :e |
							  e withDashedBorder ifTrue: [ e toTheme dashArray ] ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) }).

	" ToButton default danger"
	self addRule: (ToStyleRule new
			 selectors:
				 { ((ToStyleClassSelector new elementClass: #button) and:
					  (ToStyleClassSelector new elementClass: #danger)) }
			 looks: {
					 (ToBackgroundColorLook new
						  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
						  initialColor: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  initialPaint: [ :e | e toTheme colorError ];
						  hoverPaint: [ :e | e toTheme colorErrorHover ];
						  dashArray: [ :e |
							  e withDashedBorder ifTrue: [ e toTheme dashArray ] ];
						  pressedPaint: [ :e | e toTheme colorErrorHover darker ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) }).

]

{ #category : #'initialization-button' }
ToStyleSheet >> addLinkButtonRules [
	" ToButton link "


]

{ #category : #'initialization-button' }
ToStyleSheet >> addPrimaryButtonRules [	
	
	" ToButton primary "
	self addRule: (ToStyleRule new
			 selectors:
				 { ((ToStyleClassSelector new elementClass: #button) and:
					  (ToStyleClassSelector new elementClass: #primary)) }
			 looks: {
					 (ToBackgroundColorLook new
						  initialColor: [ :e | e toTheme colorPrimary ];
						  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
						  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
						  hoverColor: [ :e | e toTheme colorPrimaryHover ];
						  duration: 200 milliSeconds;
						  yourself).
					 (ToBorderLook new
						  initialPaint: [ :e | Color transparent ];
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) }).

	" ToButton primary danger "
	self addRule: (ToStyleRule new
			 selectors:
				 { ((ToStyleClassSelector new elementClass: #button) and:
					  ((ToStyleClassSelector new elementClass: #primary) and:
						   (ToStyleClassSelector new elementClass: #danger))) }
			 looks: {
					 (ToBackgroundColorLook new
						  initialColor: [ :e | e toTheme colorError ];
						  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
						  pressedColor: [ :e | e toTheme colorErrorPressed ];
						  hoverColor: [ :e | e toTheme colorErrorHover ];
						  yourself).
					 (ToBorderLook new
						  initialPaint: [ :e | Color transparent ];
						  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
						  width: [ :e | e toTheme lineWidth ];
						  yourself) }).

]

{ #category : #adding }
ToStyleSheet >> addRule: aStyleRule [

	rules add: aStyleRule 
]

{ #category : #'initialization-button' }
ToStyleSheet >> addTextButtonRules [

	" ToButton text "
	self addRule: (ToStyleRule new
			 selectors:
				 { ((ToStyleClassSelector new elementClass: #button) and:
					  (ToStyleClassSelector new elementClass: #text)) }
			 looks: { (ToBackgroundColorLook new
					  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
					  initialColor: [ :e | Color transparent ];
					  pressedColor: [ :e | e toTheme colorBgTextActive ];
					  hoverColor: [ :e | e toTheme colorBgTextHover ];
					  yourself) }).

	" ToButton text danger "
	self addRule: (ToStyleRule new
			 selectors:
				 { ((ToStyleClassSelector new elementClass: #button) and:
					  ((ToStyleClassSelector new elementClass: #text) and:
						   (ToStyleClassSelector new elementClass: #danger))) }
			 looks: { (ToBackgroundColorLook new
					  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
					  initialColor: [ :e | Color transparent ];
					  pressedColor: [ :e | e toTheme colorErrorBg ];
					  hoverColor: [ :e | e toTheme colorErrorBg ];
					  yourself) })
]

{ #category : #initialization }
ToStyleSheet >> initialize [ 

	super initialize.
	rules := OrderedCollection new
]

{ #category : #initialization }
ToStyleSheet >> initializeComputedValues [
	" * { background-color: #transparent; border-with: 0; border-color: #transparent} "

	self addRule:
		(ToStyleRule new
			 selectors: { ToStyleUniversalSelector new }
			 looks: {
					 ToBackgroundColorLook new.
					 ToBorderLook new }).

	self addButtonRules
]
