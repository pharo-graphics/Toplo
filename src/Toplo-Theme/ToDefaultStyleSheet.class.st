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
			 looks: { ToLook forBorder}).

	" no background for #link ( which elementClass includes #'no-background' ) "
	self addRule: (ToStyleRule new
			 selectors: { (ToClassSelector new elementClasses:
					  #( #button #'no-background' )) }
			 looks: { ToLook forBackground }).

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
					 (ToLook forBackground
						  whenInitialized: [ :e | e background: Color transparent ];
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself).
					 (ToLook forBorder
						  whenInitialized: [ :e | e border: e toTheme colorBorder ];
						  disabledValue: [ :e |
							  e toTheme colorBorderDisabled asBlBorder ];
						  hoveredValue: [ :e | e toTheme colorPrimaryHover asBlBorder ];
						  pressedValue: [ :e | e toTheme colorPrimaryPressed asBlBorder ];
						  yourself) }).

	" default button form icon "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #'form-icon')
					  parent: (ToClassSelector new elementClass: #button)
					  level: 2) }
			 looks:
				 { ((ToLook forTextForegroundWithBuilder:
						   BlTextAttributesBuilder new)
					  initialValue: [ :e | e toTheme colorText ];
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  hoveredValue: [ :e | e toTheme colorPrimary ];
					  pressedValue: [ :e | e toTheme colorPrimaryPressed ];
					  yourself) }).

	" default button label "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #label)
					  parent: (ToClassSelector new elementClass: #button)
					  level: 2) }
			 looks: { (ToLook forTextForegroundWithBuilder:
						   BlTextAttributesBuilder new)
					  initialValue: [ :e | e toTheme colorText ];
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  hoveredValue: [ :e | e toTheme colorPrimary ];
					  pressedValue: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).

	" default button dashed "
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses: #( #button #dashed )) }
			 looks: {
					 (ToBackgroundLook new
						  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
						  whenInitialized: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  whenDisabled: [ :e | e toTheme colorBorderDisabled asBlBorder ];
						  whenInitialized: [ :e | e toTheme colorBorder asBlBorder ];
						  whenHovered: [ :e | e toTheme colorPrimaryHover asBlBorder ];
						  whenPressed: [ :e | e toTheme colorPrimaryPressed asBlBorder ];
						  yourself) }).

	" ToButton default danger"
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses: #( #button #danger )) }
			 looks: {
					 (ToBackgroundLook new
						  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
						  whenInitialized: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  whenDisabled: [ :e | e toTheme colorBorderDisabled asBlBorder ];
						  whenInitialized: [ :e | e toTheme colorError asBlBorder ];
						  whenHovered: [ :e | e toTheme colorErrorHover asBlBorder ];
						  whenPressed: [ :e |
							  e toTheme colorErrorHover darker asBlBorder ];
						  yourself) }).

	" ToButton default danger dashed"
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses:
				  #( #button #danger #dashed )) }
			 looks: {
					 (ToBackgroundLook new
						  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
						  whenInitialized: [ :e | Color transparent ];
						  yourself).
					 (ToBorderLook new
						  whenDisabled: [ :e | e toTheme colorBorderDisabled asBlBorder ];
						  whenInitialized: [ :e | e toTheme colorError asBlBorder ];
						  whenHovered: [ :e | e toTheme colorErrorHover asBlBorder ];
						  whenPressed: [ :e |
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
					  whenDisabled: [ :e | e toTheme colorImageDisabled ];
					  whenInitialized: [ :e | e toTheme colorError ];
					  whenHovered: [ :e | e toTheme colorErrorHover ];
					  whenPressed: [ :e | e toTheme colorError darker ];
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
						  whenInitialized: [ :e | e toTheme colorPrimary ];
						  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
						  whenPressed:
							  ([ :e | e toTheme colorPrimaryPressed ] 
								   );
						  whenHovered:
							  ([ :e | e toTheme colorPrimaryHover ]  );
						  yourself).
					 (ToBorderLook new
						  whenInitialized: [ :e | Color transparent ];
						  whenDisabled: [ :e | e toTheme colorBorderDisabled ];
						  yourself) }).

	" ToButton primary danger "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  ((ToClassSelector new elementClass: #primary) and:
						   (ToClassSelector new elementClass: #danger))) }
			 looks: {
					 (ToBackgroundLook new
						  whenInitialized: [ :e | e toTheme colorError ];
						  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
						  whenPressed:
							  ([ :e | e toTheme colorErrorPressed ] );
						  whenHovered:
							  ([ :e | e toTheme colorErrorHover ] );
						  yourself).
					 (ToBorderLook new
						  whenInitialized: [ :e | Color transparent ];
						  whenDisabled: [ :e | e toTheme colorBorderDisabled ];
						  yourself) })
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addTextButtonRules [
	" ToButton text "

	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  (ToClassSelector new elementClass: #text)) }
			 looks: { (ToBackgroundLook new
					  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
					  whenInitialized: [ :e | Color transparent ];
					  whenPressed: [ :e | e toTheme colorBgTextActive ];
					  whenHovered: [ :e | e toTheme colorBgTextHover ];
					  yourself) }).

	" ToButton text danger "
	self addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #button) and:
					  ((ToClassSelector new elementClass: #text) and:
						   (ToClassSelector new elementClass: #danger))) }
			 looks: { (ToBackgroundLook new
					  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
					  whenInitialized: [ :e | Color transparent ];
					  whenPressed: [ :e | e toTheme colorErrorBg ];
					  whenHovered: [ :e | e toTheme colorErrorBg ];
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
