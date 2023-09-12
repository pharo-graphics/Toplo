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
			 { (ToStyleClassSelector new styleClasses:
				  #( #button #'no-border' )) }
			 looks: { ToLookDep forBorder}).

	" no background for #link ( which elementClass includes #'no-background' ) "
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses:
					  #( #button #'no-background' )) }
			 looks: { ToLookDep forBackground }).

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
			 selectors: { (ToStyleClassSelector new elementClass: #button) }
			 looks: {
					 (ToLookUpdater forProperty: (ToInstVarProperty new name: #background))
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (ToLookUpdater forProperty: (ToInstVarProperty new name: #border))
						  when: ToInitialLookEvent value: [ :e | e toTheme colorBorder ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
						  yourself }).

	" default button form icon "
	self addRule: (ToStyleRule new
			 selectors: { ((ToStyleClassSelector new elementClass: #'form-icon')
					  parent: (ToStyleClassSelector new elementClass: #button)
					  level: 2) }
			 looks:
				 { (ToLookUpdater forProperty: self imageInnerFormAttributesProperty)
					  when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).

	" default button label "
	self addRule: (ToStyleRule new
			 selectors: { ((ToStyleClassSelector new elementClass: #label)
					  parent: (ToStyleClassSelector new elementClass: #button)
					  level: 2) }
			 looks: { (ToLookUpdater forProperty: self textAttributesProperty)
					  when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).

	" default button dashed "
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToStyleClassSelector new styleClasses: #( #button #dashed )) }
			 looks: {
					 (ToLookUpdater forProperty: (ToInstVarProperty new name: #background))
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (ToLookUpdater forProperty: (ToInstVarProperty new name: #border))
						  when: ToInitialLookEvent value: [ :e | e toTheme colorBorder ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
						  yourself }).

	" ToButton default danger"
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToStyleClassSelector new styleClasses: #( #button #danger )) }
			 looks: {
					 (ToLookUpdater forProperty: (ToInstVarProperty new name: #background))
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (ToLookUpdater forProperty: (ToInstVarProperty new name: #border))
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorHover darker ];
						  yourself }).

	" ToButton default danger dashed"
	self addRule: (ToStyleRule new
			 selectors:
			 { (ToStyleClassSelector new styleClasses:
				  #( #button #danger #dashed )) }
			 looks: {
					 (ToLookUpdater forProperty: (ToInstVarProperty new name: #background))
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (ToLookUpdater forProperty: (ToInstVarProperty new name: #border))
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorHover darker ];
						  yourself }).

	" danger button form icon "
	self addRule: (ToStyleRule new
			 selectors: { ((ToStyleClassSelector new elementClass: #'form-icon')
					  parent:
					  (ToStyleClassSelector new styleClasses: #( #button #danger ))
					  level: 2) }
			 looks: { (ToLookUpdater forProperty: self imageInnerFormAttributesProperty)
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorImageDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorHover darker ];
						  yourself }).

	" danger button label "
	self addRule: (ToStyleRule new
			 selectors: { ((ToStyleClassSelector new elementClass: #label)
					  parent:
					  (ToStyleClassSelector new styleClasses: #( #button #danger ))
					  level: 2) }
			 looks: { (ToLookUpdater forProperty: (ToLookUpdater forProperty: self textAttributesProperty))
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
			 selectors: { ((ToStyleClassSelector new elementClass: #button) and:
					  (ToStyleClassSelector new elementClass: #primary)) }
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
			 selectors: { ((ToStyleClassSelector new elementClass: #button) and:
					  ((ToStyleClassSelector new elementClass: #primary) and:
						   (ToStyleClassSelector new elementClass: #danger))) }
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
			 selectors: { ((ToStyleClassSelector new elementClass: #button) and:
					  (ToStyleClassSelector new elementClass: #text)) }
			 looks: { (ToBackgroundLook new
					  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
					  whenInitialized: [ :e | Color transparent ];
					  whenPressed: [ :e | e toTheme colorBgTextActive ];
					  whenHovered: [ :e | e toTheme colorBgTextHover ];
					  yourself) }).

	" ToButton text danger "
	self addRule: (ToStyleRule new
			 selectors: { ((ToStyleClassSelector new elementClass: #button) and:
					  ((ToStyleClassSelector new elementClass: #text) and:
						   (ToStyleClassSelector new elementClass: #danger))) }
			 looks: { (ToBackgroundLook new
					  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
					  whenInitialized: [ :e | Color transparent ];
					  whenPressed: [ :e | e toTheme colorErrorBg ];
					  whenHovered: [ :e | e toTheme colorErrorBg ];
					  yourself) })
]

{ #category : #accessing }
ToDefaultStyleSheet >> imageInnerFormAttributesProperty [

	^ ToPseudoProperty new
		        name: #'inner-form';
		        reader: [ :e | e innerForm ];
		        writer: [ :e :v |
			        e
				        withInnerFormDo: [ :form |
					        e innerImage:
							        (form collectColors: [ :color | v alpha: color alpha ]) ]
				        ifNone: [  ] ].
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

{ #category : #accessing }
ToDefaultStyleSheet >> textAttributesProperty [

	^ (ToPseudoProperty new name: #'text-attributes')
		  writer: [ :e :v |
			  e text attributes: v attributes.
			  e textChanged ];
		  yourself
]
