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

	self addRule: (ToStyleRule new
			selectors: { (ToStyleClassSelector new styleClasses: #( #button )) }
			looks: { 
				(self newLookUpdaterForPropertyName: #mouseCursor)
					when: ToHoveredLookEvent value: [ :e | 
						e isEnabled
				  			ifTrue: [ BlCursor hand ]
				  			ifFalse: [  ] ];
					when: ToLeavedLookEvent value: nil;
					yourself  }).
""
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button #'no-border' )) }
			 looks: { self newLookUpdaterForPropertyName: #border }).

	" no background for #link ( which elementClass includes #'no-background' ) "
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button #'no-background' )) }
			 looks: { self newLookUpdaterForPropertyName: #background }).

					
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #'inner-element')
					parent: ((ToStyleClassSelector new styleClasses: #(#button #horizontal)) or: (ToStyleClassSelector new styleClasses: #(#button )))
					level: 1) }
			 looks: {
					(self newLookUpdaterForPropertyName: #'layout') 
							when: ToInstallLookEvent value: BlLinearLayout horizontal;
							yourself
						}
					).
		
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #'inner-element')
					parent: (ToStyleClassSelector new styleClasses: #(#button #vertical))
					level: 1) }
			 looks: {
					(self newLookUpdaterForPropertyName: #'layout') 
							when: ToInstallLookEvent value: BlLinearLayout vertical;
							yourself
						}
					).	
						
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClasses: #(#button #horizontal)) or: (ToStyleClassSelector new styleClasses: #(#button ))) }
			 looks: {
					(self newLookUpdaterForPropertyName: #'layout') 
							when: ToInstallLookEvent value: BlLinearLayout horizontal;
							yourself
						}
					).
	"self addRule: (ToStyleRule new
			 selectors: { 
				(ToStyleClassSelector new styleClasses: #(#button ""#horizontal"" #justified)) }
			 looks: {
					(self newLookUpdaterForPropertyName: #justified) 
							when: ToInstallLookEvent value: true;
							yourself
						}
					)."
	self addRule: (ToStyleRule new
			 selectors: { 
				(ToStyleClassSelector new styleClasses: #(#button #vertical))  }
			 looks: {
					(self newLookUpdaterForPropertyName: #'layout') 
							when: ToInstallLookEvent value: BlLinearLayout vertical;
							yourself
						}
					).
					
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClass: #button) or: (ToStyleClassSelector new styleClasses: #(#button horizontal))}
			 looks: {
					(self newLookUpdaterForPropertyName: #'layout-interspace')
						  when: ToInstallLookEvent value: [ :e | e toTheme paddingContentHorizontal / 3 ];
						  yourself.
					(self newLookUpdaterForPropertyName: #'padding')
						  when: ToInstallLookEvent value: [ :e | 
							BlInsets
		  						top: e toTheme paddingXS / 2
		  						left: e toTheme paddingContentHorizontal / 2
		  						bottom: e toTheme paddingXS / 2
		 						right: e toTheme paddingContentHorizontal / 2 ];
						  yourself.
					(self newLookUpdaterForPropertyName: #'geometry')
						  when: ToInstallLookEvent value: [ :e | (BlRoundedRectangleGeometry cornerRadius: e toTheme borderRadius)  ] 
						}
					).
	
	self addRule: (ToStyleRule new
		 selectors: { (ToStyleClassSelector new styleClasses: #(#button #round)) }
		 looks: {
				(self newLookUpdaterForPropertyName: #'geometry')
					  when: ToInstallLookEvent value: [ :e | 
						(BlRoundedRectangleGeometry cornerRadius: e requestedHeight / 2)  ]
					}
				)


]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addDefaultButtonRules [
	" ToButton default rule including icon and label "

	" default button (class #button) "

	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClass: #button) }
			 looks: {
					 (self newLookUpdaterForPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (self newLookUpdaterForPropertyName: #'border-with-builder')
						  when: ToInitialLookEvent value: [ :e | e borderBuilder paint: e toTheme colorBorder; yourself ];
						  when: ToDisabledLookEvent value: [ :e | e borderBuilder paint: e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e borderBuilder paint: e toTheme colorPrimaryHover ];
						  when: ToPressedLookEvent value: [ :e | e borderBuilder paint: e toTheme colorPrimaryPressed ];
						  yourself }).

	" default button form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #'image')
					parent: (ToStyleClassSelector new styleClass: #button)
					level: 2) }
			 looks:
				 { (self newLookUpdaterForPropertyName: #'image-inner-form-color')
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
			 looks: { (self newLookUpdaterForPropertyName: #'label-text-foreground')
					  when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).

	" ToButton default danger"
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #button #danger )) }
			 looks: {
					 (self newLookUpdaterForPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  yourself.
					 (self newLookUpdaterForPropertyName: #'border-with-builder')
						  when: ToInitialLookEvent value: [ :e | e borderBuilder paint: e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e borderBuilder paint:e toTheme colorBorderDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e borderBuilder paint:e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e borderBuilder paint:e toTheme colorErrorHover darker ];
						  yourself }).

	" danger button form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #image)
					  parent: (ToStyleClassSelector new styleClasses: #( #button #danger ))
					  level: 2) } 
			 looks: { 
						(self newLookUpdaterForPropertyName: #'image-inner-form-color')
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
						(self newLookUpdaterForPropertyName: #'label-text-foreground')
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorHover darker ];
					     yourself }).
					
	" default button dashed "
	self addRule: (ToStyleRule new
			 selectors: { (ToStyleClassSelector new styleClasses: #( #dashed )) }
			 looks: {
					 (self newLookUpdaterForPropertyName: #'border-with-builder')
							supplement: true;
							when: ToInstallLookEvent value: [ :e | e borderBuilder dashArray: e toTheme dashArray ];
							yourself }).
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addLinkButtonRules [
	" ToButton link "

	self addRule: (ToStyleRule new
			 selectors: { 
					(ToStyleClassSelector new styleClasses: #(#button #link)) }
			 looks: { 
					(self newLookUpdaterForPropertyName: #background)
						  	when: ToInstallLookEvent value: [ :e | Color transparent ];
						  	yourself.
					(self newLookUpdaterForPropertyName: #'border-with-builder')
						  	when: ToInstallLookEvent value: [ :e | e borderBuilder width: 0; 
							yourself ] }).

	" ToButton link danger "
	self addRule: (ToStyleRule new
			 selectors: { 
					(ToStyleClassSelector new styleClasses: #(#button #link #danger)) }
			 looks: {
					(self newLookUpdaterForPropertyName: #background)
						  	when: ToInstallLookEvent value: [ :e | Color transparent ];
						  	yourself.
					(self newLookUpdaterForPropertyName: #'border-with-builder')
						  	when: ToInstallLookEvent value: [ :e | e borderBuilder width: 0; 
							yourself ] }).
						
	" button link form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #'image')
					parent: (ToStyleClassSelector new styleClasses: #(#button #link))
					level: 2) }
			 looks:
				 { (self newLookUpdaterForPropertyName: #'image-inner-form-color')
					  	when: ToInitialLookEvent value: [ :e | e toTheme colorLink ];
					 	when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
						when: ToHoveredLookEvent value: [ :e | e toTheme colorLinkHover ];
						when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ]
					  yourself }).

	" button link label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #label)
					  parent: (ToStyleClassSelector new styleClasses: #(#button #link))
					  level: 2) }
			 looks: { (self newLookUpdaterForPropertyName: #'label-text-foreground')
					  	when: ToInitialLookEvent value: [ :e | e toTheme colorLink ];
					 	when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
						when: ToHoveredLookEvent value: [ :e | e toTheme colorLinkHover ];
						when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ]
					  yourself }).

	" button link danger form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #'image')
					parent: (ToStyleClassSelector new styleClasses: #(#button #link #danger))
					level: 2) }
			 looks:
				 { (self newLookUpdaterForPropertyName: #'image-inner-form-color')
					  	when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
					 	when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
						when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						when: ToPressedLookEvent value: [ :e | e toTheme colorError darker ]
					  yourself }).

	" button link danger label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #label)
					  parent: (ToStyleClassSelector new styleClasses: #(#button #link #danger))
					  level: 2) }
			 looks: { (self newLookUpdaterForPropertyName: #'label-text-foreground')
					  	when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
					 	when: ToDisabledLookEvent value: [ :e | e toTheme colorTextDisabled ];
						when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						when: ToPressedLookEvent value: [ :e | e toTheme colorError darker ]
					  yourself })
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addPrimaryButtonRules [
	" ToButton primary "

	self addRule: (ToStyleRule new
			 selectors: { 
					((ToStyleClassSelector new styleClass: #button) and:
					  (ToStyleClassSelector new styleClass: #primary)) }
			 looks: {			
					 (self newLookUpdaterForPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | e toTheme colorPrimary ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
						  yourself.
					 (self newLookUpdaterForPropertyName: #'border-with-builder')
						  when: ToInitialLookEvent value: [ :e | e borderBuilder paint: Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e borderBuilder paint: e toTheme colorBorderDisabled ];
						  yourself }).

	" ToButton primary danger "
	self addRule: (ToStyleRule new
			 selectors: { 
					((ToStyleClassSelector new styleClass: #button) and:
					  ((ToStyleClassSelector new styleClass: #primary) and:
						 (ToStyleClassSelector new styleClass: #danger))) }
			 looks: {	 
					(self newLookUpdaterForPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorPressed ];
						  yourself.
					 (self newLookUpdaterForPropertyName: #'border-with-builder')
						  when: ToInitialLookEvent value: [ :e | e borderBuilder paint: Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e borderBuilder paint: e toTheme colorBorderDisabled ];
						  yourself }).
						
	" primary button form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #image)
					parent: ((ToStyleClassSelector new styleClass: #button) 
									and: (ToStyleClassSelector new styleClass: #primary))
					level: 2) }
			 looks:
				 { ((self newLookUpdaterForPropertyName: #'image-inner-form-color'))
					  	when: ToDisabledLookEvent value: [ :e | e toTheme colorImageDisabled ];
						when: ToInitialLookEvent value: [ :e | e toTheme colorImageLightSolid ];
						yourself }).

	" primary button label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #label)
					  parent: ((ToStyleClassSelector new styleClass: #button) 
									and: (ToStyleClassSelector new styleClass: #primary))
					  level: 2) }
			 looks: { (self newLookUpdaterForPropertyName: #'label-text-foreground')
					  when: ToInitialLookEvent value: [ :e | e toTheme colorTextLightSolid ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  when: ToHoveredLookEvent value: [ :e | e toTheme colorTextLightSolid ];
					  when: ToPressedLookEvent value: [ :e | e toTheme colorTextLightSolid ];
					  yourself }).
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addTextButtonRules [
	" ToButton text "

	self addRule: (ToStyleRule new
			 selectors: { 
					(ToStyleClassSelector new styleClasses: #(#button #text)) }
			 looks: { 
					(self newLookUpdaterForPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorBgTextHover ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorBgTextActive ];
						  yourself.
					(self newLookUpdaterForPropertyName: #'border-with-builder')
						  when: ToInstallLookEvent value: [ :e | e borderBuilder width: 0; yourself ] }).

	" ToButton text danger "
	self addRule: (ToStyleRule new
			 selectors: { 
					(ToStyleClassSelector new styleClasses: #(#button #text #danger)) }
			 looks: {
					(self newLookUpdaterForPropertyName: #background)
						  when: ToInitialLookEvent value: [ :e | Color transparent ];
						  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
						  when: ToHoveredLookEvent value: [ :e | e toTheme colorErrorBg ];
						  when: ToPressedLookEvent value: [ :e | e toTheme colorErrorBg ];
						  yourself.
					(self newLookUpdaterForPropertyName: #'border-with-builder')
						  when: ToInstallLookEvent value: [ :e | e borderBuilder width: 0; yourself ] }).
						
	" button text form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #'image')
					parent: (ToStyleClassSelector new styleClasses: #(#button #text))
					level: 2) }
			 looks:
				 { (self newLookUpdaterForPropertyName: #'image-inner-form-color')
					  when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  yourself }).

	" button test label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #label)
					  parent: (ToStyleClassSelector new styleClasses: #(#button #text))
					  level: 2) }
			 looks: { (self newLookUpdaterForPropertyName: #'label-text-foreground')
					  when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  yourself }).

	" button text danger form icon "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #'image')
					parent: (ToStyleClassSelector new styleClasses: #(#button #text #danger))
					level: 2) }
			 looks:
				 { (self newLookUpdaterForPropertyName: #'image-inner-form-color')
					  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  yourself }).

	" button test danger label "
	self addRule: (ToStyleRule new
			 selectors: { 
				((ToStyleClassSelector new styleClass: #label)
					  parent: (ToStyleClassSelector new styleClasses: #(#button #text #danger))
					  level: 2) }
			 looks: { (self newLookUpdaterForPropertyName: #'label-text-foreground')
					  when: ToInitialLookEvent value: [ :e | e toTheme colorError ];
					  when: ToDisabledLookEvent value: [ :e | e toTheme colorBgContainerDisabled ];
					  yourself }).

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
