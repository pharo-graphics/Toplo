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
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  initialValue: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledValue: [ :e |
							  e toTheme colorBorderDisabled asBlBorder ];
						  initialValue: [ :e | e toTheme colorBorder asBlBorder ];
						  hoveredValue: [ :e |
							  e toTheme colorPrimaryHover asBlBorder ];
						  pressedValue: [ :e |
							  e toTheme colorPrimaryPressed asBlBorder ];
						  yourself) }).

	" default button form icon "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #'form-icon')
					  parent: (ToClassSelector new elementClass: #button)
					  level: 2) }
			 looks: { (ToLook new
		  				applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
					  disabledValue: [ :e | e toTheme colorImageDisabled ];
					  initialValue: [ :e | e toTheme colorText ];
					  hoveredValue: [ :e | e toTheme colorPrimary ];
					  pressedValue: [ :e | e toTheme colorPrimaryPressed ];
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
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  initialValue: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledValue: [ :e |
							  e toTheme colorBorderDisabled asBlBorder ];
						  initialValue: [ :e | e toTheme colorBorder asBlBorder ];
						  hoveredValue: [ :e |
							  e toTheme colorPrimaryHover asBlBorder ];
						  pressedValue: [ :e |
							  e toTheme colorPrimaryPressed asBlBorder ];
						  yourself) }).

	" ToButton default danger"
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses: #( #button #danger )) }
			 looks: {
					 (ToBackgroundLook new
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  initialValue: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledValue: [ :e |
							  e toTheme colorBorderDisabled asBlBorder ];
						  initialValue: [ :e | e toTheme colorError asBlBorder ];
						  hoveredValue: [ :e | e toTheme colorErrorHover asBlBorder ];
						  pressedValue: [ :e |
							  e toTheme colorErrorHover darker asBlBorder ];
						  yourself) }).

	" ToButton default danger dashed"
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses:
				  #( #button #danger #dashed )) }
			 looks: {
					 (ToBackgroundLook new
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  initialValue: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  disabledValue: [ :e |
							  e toTheme colorBorderDisabled asBlBorder ];
						  initialValue: [ :e | e toTheme colorError asBlBorder ];
						  hoveredValue: [ :e | e toTheme colorErrorHover asBlBorder ];
						  pressedValue: [ :e |
							  e toTheme colorErrorHover darker asBlBorder ];
						  yourself) }).

	" danger button form icon "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #'form-icon')
					  parent:
					  (ToClassSelector new elementClasses: #( #button #danger ))
					  level: 2) }
			 looks: { (ToLook new
		  				applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
					  disabledValue: [ :e | e toTheme colorImageDisabled ];
					  initialValue: [ :e | e toTheme colorError ];
					  hoveredValue: [ :e | e toTheme colorErrorHover ];
					  pressedValue: [ :e | e toTheme colorError darker ];
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
						  initialValue: [ :e | e toTheme colorPrimary ];
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  pressedValue:
							  ([ :e | e toTheme colorPrimaryPressed ] asStateValue
								   duration: 200 milliSeconds);
						  hoveredValue:
							  ([ :e | e toTheme colorPrimaryHover ] asStateValue duration:
									   200 milliSeconds);
						  yourself).
					 (ToBorderLook new
						  initialValue: [ :e | Color transparent ];
						  disabledValue: [ :e | e toTheme colorBorderDisabled ];
						  yourself) }).

	" ToButton primary danger "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  ((ToClassSelector new elementClass: #primary) and:
						   (ToClassSelector new elementClass: #danger))) }
			 looks: {
					 (ToBackgroundLook new
						  initialValue: [ :e | e toTheme colorError ];
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  pressedValue:
							  ([ :e | e toTheme colorErrorPressed ] asStateValue duration:
									   200 milliSeconds);
						  hoveredValue:
							  ([ :e | e toTheme colorErrorHover ] asStateValue duration:
									   200 milliSeconds);
						  yourself).
					 (ToBorderLook new
						  initialValue: [ :e | Color transparent ];
						  disabledValue: [ :e | e toTheme colorBorderDisabled ];
						  yourself) })
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addTextButtonRules [
	" ToButton text "

	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  (ToClassSelector new elementClass: #text)) }
			 looks: { (ToBackgroundLook new
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  initialValue: [ :e | Color transparent ];
					  pressedValue: [ :e | e toTheme colorBgTextActive ];
					  hoveredValue: [ :e | e toTheme colorBgTextHover ];
					  yourself) }).

	" ToButton text danger "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  ((ToClassSelector new elementClass: #text) and:
						   (ToClassSelector new elementClass: #danger))) }
			 looks: { (ToBackgroundLook new
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  initialValue: [ :e | Color transparent ];
					  pressedValue: [ :e | e toTheme colorErrorBg ];
					  hoveredValue: [ :e | e toTheme colorErrorBg ];
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
