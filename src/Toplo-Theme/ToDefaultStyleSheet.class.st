Class {
	#name : #ToDefaultStyleSheet,
	#superclass : #ToStyleSheet,
	#category : #'Toplo-Theme-DefaultTheme'
}

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addButtonRules [
	" no border for #text and #link ( which elementClass includes #'no-border' ) "

	self addCommonButtonRules.

	self addDefaultButtonRules.
	self addPrimaryButtonRules.
	self addTextButtonRules.
	self addLinkButtonRules
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addCommonButtonRules [
	" ToButton common rule for layout "

	"  for the record: thinking about a concise syntax 

	'button:hover' rule: [ :e | e mouseCursor: BlCursor hand ].
	'button:leave' rule: [ :e | e mouseCursor: nil ].

	'button' rule: [ :e | e background: Color white ].
	'button:hover' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].
	'button:hover, button:leave' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].

	"


	self addRule: (ToStyleRule new
			selectors: { (self classes: #( #button )) }
			looks: { 
				(self property: #mouseCursor)
					hoveredValue: [ :e | 
						e isEnabled
				  			ifTrue: [ BlCursor hand ]
				  			ifFalse: [  ] ];
					leavedValue: nil;
					yourself  }).
""
	self addRule: (ToStyleRule new
			 selectors: { (self classes: #( #button #'no-border' )) }
			 looks: { self property: #border }).

	" no background for #link ( which elementClass includes #'no-background' ) "
	self addRule: (ToStyleRule new
			 selectors: { (self classes: #( #button #'no-background' )) }
			 looks: { self property: #background }).

					
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #'inner-element')
					parent: ((self classes: #(#button #horizontal)) or: (self classes: #(#button )))
					level: 1) }
			 looks: {
					(self property: #'layout') 
							installValue: BlLinearLayout horizontal;
							yourself
						}
					).
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #'inner-element')
					parent: ((self classes: #(#button #horizontal #justified)) 
						or: (self classes: #(#button #justified)))
					level: 1) }
			 looks: {
					(self property: #'layout') 
							installValue: [:e | BlLinearLayout horizontal] ;
							yourself
						}
					).
		
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #'inner-element')
					parent: (self classes: #(#button #vertical))
					level: 1) }
			 looks: {
					(self property: #'layout') 
							installValue: BlLinearLayout vertical;
							yourself
						}
					).	
						
	self addRule: (ToStyleRule new
			 selectors: { 
				((self classes: #(#button #horizontal)) or: (self classes: #(#button ))) }
			 looks: {
					(self property: #'layout') 
							installValue: BlLinearLayout horizontal;
							yourself
						}
					).

					
	self addRule: (ToStyleRule new
			 selectors: { 
				(self classes: #(#button #vertical))  }
			 looks: {
					(self property: #'layout') 
							installValue: BlLinearLayout vertical;
							yourself
						}
					).
					
	self addRule: (ToStyleRule new
			 selectors: { (self class: #button) or: (self classes: #(#button #horizontal))}
			 looks: {
					(self property: #'layout-interspace')
						  installValue: [ :e | e toTheme paddingContentHorizontal / 3 ];
						  yourself.
					(self property: #'padding')
						  installValue: [ :e | 
							BlInsets
		  						top: e toTheme paddingXS / 2
		  						left: e toTheme paddingContentHorizontal / 2
		  						bottom: e toTheme paddingXS / 2
		 						right: e toTheme paddingContentHorizontal / 2 ];
						  yourself.
					(self property: #'geometry')
						  installValue: [ :e | (BlRoundedRectangleGeometry cornerRadius: e toTheme borderRadius)  ] 
						}
					).
	
	self addRule: (ToStyleRule new
		 selectors: { (self classes: #(#button #round)) }
		 looks: {
				(self property: #'geometry')
					  installValue: [ :e | 
						(BlRoundedRectangleGeometry cornerRadius: e requestedHeight / 2)  ]
					}
				).

	self addRule: (ToStyleRule new
			 selectors: { 
				(self classes: #(#button #horizontal #justified)) or: (self classes: #(#button #justified)) }
			 looks: {
					(self property: #justified) 
							installValue: true;
							yourself
						}
					).

]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addDefaultButtonRules [
	" ToButton default rule including icon and label "

	" default button (class #button) "

	self addRule: (ToStyleRule new
			 selectors: { (self class: #button) }
			 looks: {
					 (self property: #background)
						  initialValue: [ :e | Color transparent ];
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (self property: #'border-with-builder')
						  initialValue: [ :e | e borderBuilder paint: e toTheme colorBorder; yourself ];
						  disabledValue: [ :e | e borderBuilder paint: e toTheme colorBorderDisabled ];
						  hoveredValue: [ :e | e borderBuilder paint: e toTheme colorPrimaryHover ];
						  pressedValue: [ :e | e borderBuilder paint: e toTheme colorPrimaryPressed ];
						  yourself }).

	" default button form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #'image')
					parent: (self class: #button)
					level: 2) }
			 looks:
				 { (self property: #'image-inner-form-color')
					  initialValue: [ :e | e toTheme colorText ];
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  hoveredValue: [ :e | e toTheme colorPrimary ];
					  pressedValue: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).

	" default button label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #label)
					  parent: (self class: #button)
					  level: 2) }
			 looks: { (self property: #'label-text-foreground')
					  initialValue: [ :e | e toTheme colorText ];
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  hoveredValue: [ :e | e toTheme colorPrimary ];
					  pressedValue: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).

	" ToButton default danger"
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button #danger )) }
			 looks: {
					 (self property: #background)
						  initialValue: [ :e | Color transparent ];
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (self property: #'border-with-builder')
						  initialValue: [ :e | e borderBuilder paint: e toTheme colorError ];
						  disabledValue: [ :e | e borderBuilder paint:e toTheme colorBorderDisabled ];
						  hoveredValue: [ :e | e borderBuilder paint:e toTheme colorErrorHover ];
						  pressedValue: [ :e | e borderBuilder paint:e toTheme colorErrorHover darker ];
						  yourself }).

	" danger button form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #image)
					  parent: (self classes: #( #button #danger ))
					  level: 2) } 
			 looks: { 
						(self property: #'image-inner-form-color')
						  initialValue: [ :e | e toTheme colorError ];
						  disabledValue: [ :e | e toTheme colorImageDisabled ];
						  hoveredValue: [ :e | e toTheme colorErrorHover ];
						  pressedValue: [ :e | e toTheme colorErrorHover darker ];
						  yourself }).

	" danger button label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #label)
					parent: (self classes: #( #button #danger ))
					level: 2) }
			 looks: { 
						(self property: #'label-text-foreground')
						  initialValue: [ :e | e toTheme colorError ];
						  disabledValue: [ :e | e toTheme colorTextDisabled ];
						  hoveredValue: [ :e | e toTheme colorErrorHover ];
						  pressedValue: [ :e | e toTheme colorErrorHover darker ];
					     yourself }).
					
	" default button dashed "
	self addRule: (ToStyleRule new
			 selectors: { (self classes: #( #dashed )) }
			 looks: {
					 (self property: #'border-with-builder')
							supplement: true;
							when: ToInstallLookEvent value: [ :e | e borderBuilder dashArray: e toTheme dashArray ];
							yourself }).
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addLinkButtonRules [
	" ToButton link "

	self addRule: (ToStyleRule new
			 selectors: { 
					(self classes: #(#button #link)) }
			 looks: { 
					(self property: #background)
						  	installValue: [ :e | Color transparent ];
						  	yourself.
					(self property: #'border-with-builder')
						  	installValue: [ :e | e borderBuilder width: 0; 
							yourself ] }).

	" ToButton link danger "
	self addRule: (ToStyleRule new
			 selectors: { 
					(self classes: #(#button #link #danger)) }
			 looks: {
					(self property: #background)
						  	installValue: [ :e | Color transparent ];
						  	yourself.
					(self property: #'border-with-builder')
						  	installValue: [ :e | e borderBuilder width: 0; 
							yourself ] }).
						
	" button link form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #'image')
					parent: (self classes: #(#button #link))
					level: 2) }
			 looks:
				 { (self property: #'image-inner-form-color')
					  	initialValue: [ :e | e toTheme colorLink ];
					 	disabledValue: [ :e | e toTheme colorTextDisabled ];
						hoveredValue: [ :e | e toTheme colorLinkHover ];
						pressedValue: [ :e | e toTheme colorPrimaryPressed ]
					  yourself }).

	" button link label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #label)
					  parent: (self classes: #(#button #link))
					  level: 2) }
			 looks: { (self property: #'label-text-foreground')
					  	initialValue: [ :e | e toTheme colorLink ];
					 	disabledValue: [ :e | e toTheme colorTextDisabled ];
						hoveredValue: [ :e | e toTheme colorLinkHover ];
						pressedValue: [ :e | e toTheme colorPrimaryPressed ]
					  yourself }).

	" button link danger form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #'image')
					parent: (self classes: #(#button #link #danger))
					level: 2) }
			 looks:
				 { (self property: #'image-inner-form-color')
					  	initialValue: [ :e | e toTheme colorError ];
					 	disabledValue: [ :e | e toTheme colorTextDisabled ];
						hoveredValue: [ :e | e toTheme colorErrorHover ];
						pressedValue: [ :e | e toTheme colorError darker ]
					  yourself }).

	" button link danger label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #label)
					  parent: (self classes: #(#button #link #danger))
					  level: 2) }
			 looks: { (self property: #'label-text-foreground')
					  	initialValue: [ :e | e toTheme colorError ];
					 	disabledValue: [ :e | e toTheme colorTextDisabled ];
						hoveredValue: [ :e | e toTheme colorErrorHover ];
						pressedValue: [ :e | e toTheme colorError darker ]
					  yourself })
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addPrimaryButtonRules [
	" ToButton primary "

	self addRule: (ToStyleRule new
			 selectors: { 
					((self class: #button) and:
					  (self class: #primary)) }
			 looks: {			
					 (self property: #background)
						  initialValue: [ :e | e toTheme colorPrimary ];
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  hoveredValue: [ :e | e toTheme colorPrimaryHover ];
						  pressedValue: [ :e | e toTheme colorPrimaryPressed ];
						  yourself.
					 (self property: #'border-with-builder')
						  initialValue: [ :e | e borderBuilder paint: Color transparent ];
						  disabledValue: [ :e | e borderBuilder paint: e toTheme colorBorderDisabled ];
						  yourself }).

	" ToButton primary danger "
	self addRule: (ToStyleRule new
			 selectors: { 
					((self class: #button) and:
					  ((self class: #primary) and:
						 (self class: #danger))) }
			 looks: {	 
					(self property: #background)
						  initialValue: [ :e | e toTheme colorError ];
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  hoveredValue: [ :e | e toTheme colorErrorHover ];
						  pressedValue: [ :e | e toTheme colorErrorPressed ];
						  yourself.
					 (self property: #'border-with-builder')
						  initialValue: [ :e | e borderBuilder paint: Color transparent ];
						  disabledValue: [ :e | e borderBuilder paint: e toTheme colorBorderDisabled ];
						  yourself }).
						
	" primary button form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #image)
					parent: ((self class: #button) 
									and: (self class: #primary))
					level: 2) }
			 looks:
				 { ((self property: #'image-inner-form-color'))
					  	disabledValue: [ :e | e toTheme colorImageDisabled ];
						initialValue: [ :e | e toTheme colorImageLightSolid ];
						yourself }).

	" primary button label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #label)
					  parent: ((self class: #button) 
									and: (self class: #primary))
					  level: 2) }
			 looks: { (self property: #'label-text-foreground')
					  initialValue: [ :e | e toTheme colorTextLightSolid ];
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  hoveredValue: [ :e | e toTheme colorTextLightSolid ];
					  pressedValue: [ :e | e toTheme colorTextLightSolid ];
					  yourself }).
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addTextButtonRules [
	" ToButton text "

	self addRule: (ToStyleRule new
			 selectors: { 
					(self classes: #(#button #text)) }
			 looks: { 
					(self property: #background)
						  initialValue: [ :e | Color transparent ];
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  hoveredValue: [ :e | e toTheme colorBgTextHover ];
						  pressedValue: [ :e | e toTheme colorBgTextActive ];
						  yourself.
					(self property: #'border-with-builder')
						  installValue: [ :e | e borderBuilder width: 0; yourself ] }).

	" ToButton text danger "
	self addRule: (ToStyleRule new
			 selectors: { 
					(self classes: #(#button #text #danger)) }
			 looks: {
					(self property: #background)
						  initialValue: [ :e | Color transparent ];
						  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
						  hoveredValue: [ :e | e toTheme colorErrorBg ];
						  pressedValue: [ :e | e toTheme colorErrorBg ];
						  yourself.
					(self property: #'border-with-builder')
						  installValue: [ :e | e borderBuilder width: 0; yourself ] }).
						
	" button text form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #'image')
					parent: (self classes: #(#button #text))
					level: 2) }
			 looks:
				 { (self property: #'image-inner-form-color')
					  initialValue: [ :e | e toTheme colorText ];
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  yourself }).

	" button test label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #label)
					  parent: (self classes: #(#button #text))
					  level: 2) }
			 looks: { (self property: #'label-text-foreground')
					  initialValue: [ :e | e toTheme colorText ];
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  yourself }).

	" button text danger form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #'image')
					parent: (self classes: #(#button #text #danger))
					level: 2) }
			 looks:
				 { (self property: #'image-inner-form-color')
					  initialValue: [ :e | e toTheme colorError ];
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  yourself }).

	" button test danger label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((self class: #label)
					  parent: (self classes: #(#button #text #danger))
					  level: 2) }
			 looks: { (self property: #'label-text-foreground')
					  initialValue: [ :e | e toTheme colorError ];
					  disabledValue: [ :e | e toTheme colorBgContainerDisabled ];
					  yourself }).

]

{ #category : #'syntactic sugar' }
ToDefaultStyleSheet >> class: aSymbol [

 	^ ToStyleClassSelector new styleClass: aSymbol

]

{ #category : #'syntactic sugar' }
ToDefaultStyleSheet >> classes: anArray [

 	^ ToStyleClassSelector new styleClasses: anArray

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

{ #category : #'syntactic sugar' }
ToDefaultStyleSheet >> property: aSymbol [

	^ self newLookUpdaterForPropertyName: aSymbol
]
