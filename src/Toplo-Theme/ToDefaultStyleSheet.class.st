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
	self addRules: self linkButtonRules.
	self addRules: self checkableButtonRules.
	self addRules: self checkableInnerImageRules
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
ToDefaultStyleSheet >> checkableButtonRules [
	" checkbox family "

	^ {
		  ((self tags: #( #button #checkable )) style: [ :sr |
			   | switch |
			   switch := [ :e |
			             e isChecked
				             ifTrue: [ e checkedImage ]
				             ifFalse: [
					             e isUnchecked
						             ifTrue: [ e uncheckedImage ]
						             ifFalse: [ e indeterminateImage ] ] ].
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'checkable-icon-image')
				   with: switch.
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'checkable-icon-image')
				   with: switch.
			   sr
				   when: ToClickedLookEvent
				   write: (self property: #'checkable-icon-image')
				   with: switch.
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorderCheckable;
						   yourself ] ]).

		  " checkbox icon geometry "
		  (((self tag: #image)
			    parent: (self tags: #( #button #checkable #checkbox ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #geometry)
				   with: [ :e | BlRoundedRectangleGeometry cornerRadius: 3 ] ]).

		  " radio button icon geometry "
		  (((self tag: #image)
			    parent: (self tags: #( #button #checkable #radio ))
			    level: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #geometry)
				   with: [ :e | BlCircleGeometry new ] ]).

		  (((self tag: #image)
			    parent: (self tags: #( #button #checkable ))
			    level: 2) style: [ :sr | " icon border "
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorder;
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorderDisabled;
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorPrimaryHover;
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorPrimaryPressed;
						   yourself ] ]).

		  (((self tag: #image)
			    parent: (self tags: #( #button #checkable #danger ))
			    level: 2) style: [ :sr | " icon border "
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorError;
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorderDisabled;
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorErrorHover;
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorErrorHover darker;
						   yourself ] ]) }
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> checkableInnerImageRules [
	" checkbox family "

	^ {
		  (((self tags: #( #checkable #'inner-image' ))
			    parent: (self tags: #( #button #checkable ))
			    level: 3) style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlFrameLayout new ].
			   sr
				   write: (self property: #size)
				   with: [ :e | (e toTheme controlHeight / 2) asPoint ].
			   sr
				   write: (self property: #margin)
				   with: [ :e | BlInsets all: 0 ] ]).

		  (((self tags: #( #checkable #'inner-image' #indeterminate #bar ))
			    parent: ((self tags: #( #checkable #'inner-image' ))
					     parent: (self tags: #( #button #checkable ))
					     level: 3)
			    level: 1) style: [ :sr |
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal matchParent.
				   c vertical exact: 4.
				   c frame horizontal alignCenter.
				   c frame vertical alignCenter ] ].
			   sr
				   write: (self property: #background)
				   with: [ :e | e toTheme colorPrimary ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ].
			   sr
				   write: (self property: #margin)
				   with: [ :e | BlInsets all: 0 ] ]).

		  (((self tags: #( #checkable #'inner-image' #indeterminate
		        #bar ))
			    parent: ((self tags: #( #checkable #'inner-image' ))
					     parent: (self tags: #( #button #checkable #danger ))
					     level: 3)
			    level: 1) style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: [ :e | e toTheme colorError ] ]).

		  (((self tags: #( #checkable #'inner-image' #indeterminate ))
			    parent: (self tags: #( #button #checkable ))
			    level: 4) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #margin)
				   with: [ :e | BlInsets all: 2 ] ]).

		  (((self tags: #( #checkable #'inner-image' #checked ))
			    parent: (self tags: #( #button #checkable ))
			    level: 3) style: [ :sr | " icon border "
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorPrimary;
						   width: 6;
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorderDisabled;
						   width: 6;
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorPrimaryHover;
						   width: 6;
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorPrimaryPressed;
						   width: 6;
						   yourself ] ]).

		  (((self tags: #( #checkable #'inner-image' #unchecked ))
			    parent: (self tags: #( #button #checkable ))
			    level: 3) style: [ :sr | " icon border "
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ] ]).

		  (((self tags: #( #checkable #'inner-image' #checked ))
			    parent: (self tags: #( #button #checkable #danger ))
			    level: 3) style: [ :sr | " icon border "
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorError;
						   width: 6;
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorderDisabled;
						   width: 6;
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorErrorHover;
						   width: 6;
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorErrorHover darker;
						   width: 6;
						   yourself ] ]).

		  (((self tags: #( #checkable #'inner-image' #unchecked ))
			    parent: (self tags: #( #button #checkable #danger ))
			    level: 3) style: [ :sr | 
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 1;
						   yourself ] ]) }
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
		  ((self tag: #button) style: [ :sr |
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


		  (((self tag: #'inner-element')
			    parent: ((self tags: #( #button #horizontal )) or:
					     (self tags: #( #button )))
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: BlLinearLayout horizontal.
			   sr
				   write: (self property: #'layout-interspace')
				   with: [ :e | e toTheme paddingContentHorizontal / 3 ] ]).

		  (((self tag: #'inner-element')
			    parent:
				    ((self tags: #( #button #horizontal #justified )) or:
					     (self tags: #( #button #justified )))
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlLinearLayout horizontal ] ]).

		  (((self tag: #'inner-element')
			    parent: (self tags: #( #button #vertical ))
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr write: (self property: #layout) with: BlLinearLayout vertical ]).

		  (((self tags: #( #button #horizontal )) or:
			    (self tags: #( #button )))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: BlLinearLayout horizontal ]).

		  ((self tags: #( #button #vertical ))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: BlLinearLayout vertical ]).

		  (((self tag: #button) or:
			    (self tags: #( #button #horizontal )))
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

		  ((self tags: #( #button #round ))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #geometry)
					   with: [ :e |
					   BlRoundedRectangleGeometry cornerRadius: e requestedHeight / 2 ] ]).

		  (((self tags: #( #button #horizontal #justified )) or:
			    (self tags: #( #button #justified )))
			   when: ToInstallLookEvent
			   style: [ :sr | sr write: (self property: #justified) with: true ]) }
]

{ #category : #'initialization-button' }
ToDefaultStyleSheet >> defaultButtonRules [
	" ToButton default rule including icon and label "

	" default button (class #button) "

	^ {
		  ((self tag: #button) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  (((self tag: #button) and: (self tag: #checkable) not) style: [
			   :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorder;
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorderDisabled;
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorPrimaryHover;
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorPrimaryPressed;
						   yourself ] ]).

		  " default button form icon "
		  (((self tag: #image) parent: (self tag: #button) level: 2)
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
		  (((self tag: #label) parent: (self tag: #button) level: 2)
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorText ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorTextDisabled ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorPrimary ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorPrimaryPressed ] ]).

		  " ToButton default danger"
		  (((self tags: #( #button #danger )) and:
			    (self tag: #checkable) not) style: [ :sr |
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
		  (((self tag: #image)
			    parent: (self tags: #( #button #danger ))
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
		  (((self tag: #label)
			    parent: (self tags: #( #button #danger ))
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
		  ((self tags: #( #dashed )) style: [ :sr |
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
		  ((self tags: #( #button #link ))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " ToButton link danger "
		  ((self tags: #( #button #link #danger ))
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " button link form icon "
		  (((self tag: #image)
			    parent: (self tags: #( #button #link ))
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
		  (((self tag: #label)
			    parent: (self tags: #( #button #link ))
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
		  (((self tag: #image)
			    parent: (self tags: #( #button #link #danger ))
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
		  (((self tag: #label)
			    parent: (self tags: #( #button #link #danger ))
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
		  (((self tag: #button) and: (self tag: #primary)) style: [ :sr |
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
		  (((self tag: #button) and:
			    ((self tag: #primary) and: (self tag: #danger))) style: [
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

		  (((self tag: #image)
			    parent: ((self tag: #button) and: (self tag: #primary))
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

		  (((self tag: #label)
			    parent: ((self tag: #button) and: (self tag: #primary))
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
		  ((self tags: #( #button #text )) style: [ :sr |
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

		  ((self tags: #( #button #text #danger )) style: [ :sr |
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

		  (((self tag: #image)
			    parent: (self tags: #( #button #text ))
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

		  (((self tag: #label)
			    parent: (self tags: #( #button #text ))
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

		  (((self tag: #image)
			    parent: (self tags: #( #button #text #danger ))
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

		  (((self tag: #label)
			    parent: (self tags: #( #button #text #danger ))
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
