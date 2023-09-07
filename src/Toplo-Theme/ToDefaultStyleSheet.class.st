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
						  disabledStateValue: [ :e |
							  e toTheme colorBorderDisabled asBlBorder ];
						  initialStateValue: [ :e | e toTheme colorBorder asBlBorder ];
						  hoveredStateValue: [ :e |
							  e toTheme colorPrimaryHover asBlBorder ];
						  pressedStateValue: [ :e |
							  e toTheme colorPrimaryPressed asBlBorder ];
						  yourself) }).

	" default button form icon "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #'form-icon')
					  parent: (ToClassSelector new elementClass: #button)
					  level: 2) }
			 looks: { (ToImageFormLook new
					  disabledStateValue: [ :e | e toTheme colorImageDisabled ];
					  initialStateValue: [ :e | e toTheme colorText ];
					  hoveredStateValue: [ :e | e toTheme colorPrimary ];
					  pressedStateValue: [ :e | e toTheme colorPrimaryPressed ];
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
						  disabledStateValue: [ :e |
							  e toTheme colorBorderDisabled asBlBorder ];
						  initialStateValue: [ :e | e toTheme colorBorder asBlBorder ];
						  hoveredStateValue: [ :e |
							  e toTheme colorPrimaryHover asBlBorder ];
						  pressedStateValue: [ :e |
							  e toTheme colorPrimaryPressed asBlBorder ];
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
						  disabledStateValue: [ :e |
							  e toTheme colorBorderDisabled asBlBorder ];
						  initialStateValue: [ :e | e toTheme colorError asBlBorder ];
						  hoveredStateValue: [ :e | e toTheme colorErrorHover asBlBorder ];
						  pressedStateValue: [ :e |
							  e toTheme colorErrorHover darker asBlBorder ];
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
						  disabledStateValue: [ :e |
							  e toTheme colorBorderDisabled asBlBorder ];
						  initialStateValue: [ :e | e toTheme colorError asBlBorder ];
						  hoveredStateValue: [ :e | e toTheme colorErrorHover asBlBorder ];
						  pressedStateValue: [ :e |
							  e toTheme colorErrorHover darker asBlBorder ];
						  yourself) }).

	" danger button form icon "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #'form-icon')
					  parent:
					  (ToClassSelector new elementClasses: #( #button #danger ))
					  level: 2) }
			 looks: { (ToImageFormLook new
					  disabledStateValue: [ :e | e toTheme colorImageDisabled ];
					  initialStateValue: [ :e | e toTheme colorError ];
					  hoveredStateValue: [ :e | e toTheme colorErrorHover ];
					  pressedStateValue: [ :e | e toTheme colorError darker ];
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
						  pressedStateValue:
							  ([ :e | e toTheme colorPrimaryPressed ] asStateValue
								   duration: 200 milliSeconds);
						  hoveredStateValue:
							  ([ :e | e toTheme colorPrimaryHover ] asStateValue duration:
									   200 milliSeconds);
						  yourself).
					 (ToBorderLook new
						  initialStateValue: [ :e | Color transparent ];
						  disabledStateValue: [ :e | e toTheme colorBorderDisabled ];
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
						  pressedStateValue:
							  ([ :e | e toTheme colorErrorPressed ] asStateValue duration:
									   200 milliSeconds);
						  hoveredStateValue:
							  ([ :e | e toTheme colorErrorHover ] asStateValue duration:
									   200 milliSeconds);
						  yourself).
					 (ToBorderLook new
						  initialStateValue: [ :e | Color transparent ];
						  disabledStateValue: [ :e | e toTheme colorBorderDisabled ];
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
					  hoveredStateValue: [ :e | e toTheme colorBgTextHover ];
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
					  hoveredStateValue: [ :e | e toTheme colorErrorBg ];
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
