Class {
	#name : #ToDefaultStyleSheet,
	#superclass : #ToStyleSheet,
	#category : #'Toplo-Theme-DefaultTheme'
}

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> addButtonRules [

	self addRules: self commonButtonRules.
	self addRules: self defaultButtonRules.
	self addRules: self primaryButtonRules.
	self addRules: self textButtonRules.
	self addRules: self linkButtonRules
]

{ #category : #initialization }
ToDefaultStyleSheet >> addRootPaneRules [

	self addRules:
		{ ((self id: #'Space root') when: ToInstallLookEvent style: [ :sr |
			 sr
				 write: (self property: #background)
				 with: [ :e | e toTheme backgroundColor ] ]) }
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> commonButtonRules [
	" ToButton common rule for layout "

	"  for the record: thinking about a concise syntax 

	'button:hover' rule: [ :e | e mouseCursor: BlCursor hand. e background: Color gray. e font-size: 18 ].
	'button:leave' rule: [ :e | e mouseCursor: nil ].

	'button' rule: [ :e | e background: Color white ].
	'button:hover' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].
	'button:hover, button:leave' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].
	"

	^ {
		  ((self class: #button) style: [ :sr |
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #mouseCursor)
				   with: [ :e |
					   e isEnabled
						   ifTrue: [ BlCursor hand ]
						   ifFalse: [  ] ].
			   sr
				   when: ToLeavedLookEvent
				   write: (self property: #mouseCursor)
				   with: nil ]).
		  ""
		  ((self classes: #( #button #'no-border' )) style: [ :sr |
			   sr write: (self property: #border) with: BlBorder empty ]).

		  " no background for #link ( which elementClass includes #'no-background' ) "
		  ((self classes: #( #button #'no-background' )) style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: BlBackground transparent ]).


		  (((self class: #'inner-element')
			    parent: ((self classes: #( #button #horizontal )) or:
					     (self classes: #( #button )))
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: BlLinearLayout horizontal.
			   sr
				   write: (self property: #'layout-interspace')
				   with: [ :e | e toTheme paddingContentHorizontal / 3 ] ]).

		  (((self class: #'inner-element')
			    parent:
				    ((self classes: #( #button #horizontal #justified )) or:
					     (self classes: #( #button #justified )))
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlLinearLayout horizontal ] ]).

		  (((self class: #'inner-element')
			    parent: (self classes: #( #button #vertical ))
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr write: (self property: #layout) with: BlLinearLayout vertical ]).

		  (((self classes: #( #button #horizontal )) or:
			    (self classes: #( #button )))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: BlLinearLayout horizontal ]).

		  ((self classes: #( #button #vertical ))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: BlLinearLayout vertical ]).

		  (((self class: #button) or:
			    (self classes: #( #button #horizontal )))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr write: (self property: #padding) with: [ :e |
					   BlInsets
						   top: e toTheme paddingXS / 2
						   left: e toTheme paddingContentHorizontal / 2
						   bottom: e toTheme paddingXS / 2
						   right: e toTheme paddingContentHorizontal / 2 ].
				   sr write: (self property: #geometry) with: [ :e |
					   BlRoundedRectangleGeometry cornerRadius:
						   e toTheme borderRadius ] ]).

		  ((self classes: #( #button #round ))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #geometry)
					   with: [ :e |
					   BlRoundedRectangleGeometry cornerRadius: e requestedHeight / 2 ] ]).

		  (((self classes: #( #button #horizontal #justified )) or:
			    (self classes: #( #button #justified )))
			   when: ToInstallLookEvent
			   style: [ :sr | sr write: (self property: #justified) with: true ]) }
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> defaultButtonRules [
	" ToButton default rule including icon and label "

	" default button (class #button) "

	^ {
		  ((self class: #button) when: ToInitialLookEvent style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr write: (self property: #'border-with-builder') with: [ :e |
				   e borderBuilder
					   paint: e toTheme colorBorder;
					   yourself ] ]).
		  ((self class: #button) when: ToDisabledLookEvent style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ].
			   sr write: (self property: #'border-with-builder') with: [ :e |
				   e borderBuilder
					   paint: e toTheme colorBorderDisabled;
					   yourself ] ]).

		  ((self class: #button) when: ToHoveredLookEvent style: [ :sr |
			   sr
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: e toTheme colorPrimaryHover ] ]).
		  ((self class: #button) when: ToPressedLookEvent style: [ :sr |
			   sr
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: e toTheme colorPrimaryPressed ] ]).

		  " default button form icon "
		  (((self class: #image) parent: (self class: #button) level: 2)
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e toTheme colorText ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e toTheme colorBgContainerDisabled ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e toTheme colorPrimary ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e toTheme colorPrimaryPressed ] ]).

		  " default button label "
		  (((self class: #label) parent: (self class: #button) level: 2)
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorText ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorBgContainerDisabled ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorPrimary ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorPrimaryPressed ] ]).

		  " ToButton default danger"
		  ((ToStyleClassSelector new styleClasses: #( #button #danger ))
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #background)
					   with: [ :e | e toTheme colorBgContainerDisabled ].
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder paint: e toTheme colorError ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
					   e borderBuilder paint: e toTheme colorBorderDisabled ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder paint: e toTheme colorErrorHover ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
					   e borderBuilder paint: e toTheme colorErrorHover darker ] ]).

		  " danger button form icon "
		  (((self class: #image)
			    parent: (self classes: #( #button #danger ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorError ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorImageDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorErrorHover ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorErrorHover darker ] ]).

		  " danger button label "
		  (((self class: #label)
			    parent: (self classes: #( #button #danger ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorError ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorTextDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorErrorHover ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorErrorHover darker ] ]).

		  " default button dashed "
		  ((self classes: #( #dashed )) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder dashArray: e toTheme dashArray ] ]) }
]

{ #category : #initialization }
ToDefaultStyleSheet >> initialize [ 

	super initialize.
	self initializeDefaultThemeRules
]

{ #category : #initialization }
ToDefaultStyleSheet >> initializeDefaultThemeRules [
	" * { background-color: #transparent; border-with: 0; border-color: #transparent} "


	self addRootPaneRules.
	self addButtonRules
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> linkButtonRules [
	" ToButton link "

	^ {
		  ((self classes: #( #button #link ))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " ToButton link danger "
		  ((self classes: #( #button #link #danger ))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " button link form icon "
		  (((self class: #image)
			    parent: (self classes: #( #button #link ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorLink ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorTextDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorLinkHover ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorPrimaryPressed ] ]).

		  " button link label "
		  (((self class: #label)
			    parent: (self classes: #( #button #link ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorLink ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorTextDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorLinkHover ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorPrimaryPressed ] ]).

		  " button link danger form icon "
		  (((self class: #image)
			    parent: (self classes: #( #button #link #danger ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorError ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorTextDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorErrorHover ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorError darker ] ]).

		  " button link danger label "
		  (((self class: #label)
			    parent: (self classes: #( #button #link #danger ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorError ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorTextDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorErrorHover ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorError darker ] ]) }
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> primaryButtonRules [
	" ToButton primary "

	^ {
		  (((self class: #button) and: (self class: #primary)) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorPrimary ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | e toTheme colorPrimaryHover ]
				   animation: ToPropertyColorTransitionAnimation new.
			   sr
				   when: ToLeavedLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | e toTheme colorPrimary ]
				   animation: ToPropertyColorTransitionAnimation new.
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorPrimaryPressed ].

			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: e toTheme colorBorderDisabled ] ]).

		  " ToButton primary danger "
		  (((self class: #button) and:
			    ((self class: #primary) and: (self class: #danger))) style: [
			   :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorError ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | e toTheme colorErrorHover ]
				   animation: ToPropertyColorTransitionAnimation new.
			   sr
				   when: ToLeavedLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | e toTheme colorError ]
				   animation: ToPropertyColorTransitionAnimation new.
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorErrorPressed ].

			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: e toTheme colorBorderDisabled ] ]).

		  " primary button form icon "

		  (((self class: #image)
			    parent: ((self class: #button) and: (self class: #primary))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorImageLightSolid ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorImageDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorImageLightSolid ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorImageLightSolid ] ]).

		  " primary button label "

		  (((self class: #label)
			    parent: ((self class: #button) and: (self class: #primary))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorTextLightSolid ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorBgContainerDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorTextLightSolid ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorTextLightSolid ] ]) }
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> textButtonRules [
	" ToButton text "

	^ {
		  ((self classes: #( #button #text )) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgTextHover ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgTextActive ].

			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ] ]).

		  " ToButton text danger "

		  ((self classes: #( #button #text #danger )) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorErrorBg ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorErrorBg ].

			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ] ]).

		  " button text form icon "

		  (((self class: #image)
			    parent: (self classes: #( #button #text ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorText ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  " button test label "

		  (((self class: #label)
			    parent: (self classes: #( #button #text ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorText ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  " button text danger form icon "

		  (((self class: #image)
			    parent: (self classes: #( #button #text #danger ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorError ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  " button test danger label "

		  (((self class: #label)
			    parent: (self classes: #( #button #text #danger ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorError ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]) }
]
