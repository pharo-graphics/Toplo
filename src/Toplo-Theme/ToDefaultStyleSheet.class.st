Class {
	#name : #ToDefaultStyleSheet,
	#superclass : #ToStyleSheet,
	#category : #'Toplo-Theme-DefaultTheme'
}

{ #category : #initialization }
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
ToDefaultStyleSheet >> addLabelRules [

	self addRules: self labelRules
]

{ #category : #initialization }
ToDefaultStyleSheet >> addRootPaneRules [

	self addRules:
		{ ((self id: #'Space root') when: ToInstallLookEvent style: [ :sr |
			 sr
				 write: (self property: #background)
				 with: [ :e | e toTheme backgroundColor ] ]) }
]

{ #category : #'initialization - button' }
ToDefaultStyleSheet >> checkableButtonRules [
	" checkbox family "

	^ {
		  (#( #button #checkable ) asToStyleSelector style: [ :sr |
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
		  ((#image asToStyleSelector
			    parent: #( #button #checkable #checkbox )
			    level: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #geometry)
				   with: [ :e | BlRoundedRectangleGeometry cornerRadius: 3 ] ]).

		  " radio button icon geometry "
		  ((#image asToStyleSelector
			    parent: #( #button #checkable #radio )
			    level: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #geometry)
				   with: [ :e | BlCircleGeometry new ] ]).

		  ((#image asToStyleSelector
			    parent: #( #button #checkable )
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

		  ((#image asToStyleSelector
			    parent: #( #button #checkable #danger )
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

{ #category : #'initialization - button' }
ToDefaultStyleSheet >> checkableInnerImageRules [
	" checkbox family "

	^ {
		  ((#( #checkable #'inner-image' ) asToStyleSelector
			    parent: #( #button #checkable )
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

		  ((#( #checkable #'inner-image' #indeterminate #bar ) asToStyleSelector
			    parent: (#( #checkable #'inner-image' ) asToStyleSelector
					     parent: #( #button #checkable )
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

		  ((#( #checkable #'inner-image' #indeterminate #bar ) asToStyleSelector
			    parent: (#( #checkable #'inner-image' ) asToStyleSelector
					     parent: #( #button #checkable #danger )
					     level: 3)
			    level: 1) style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: [ :e | e toTheme colorError ] ]).

		  ((#( #checkable #'inner-image' #indeterminate ) asToStyleSelector
			    parent: #( #button #checkable )
			    level: 4) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #margin)
				   with: [ :e | BlInsets all: 2 ] ]).

		  ((#( #checkable #'inner-image' #checked ) asToStyleSelector
			    parent: #( #button #checkable )
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

		  ((#( #checkable #'inner-image' #unchecked ) asToStyleSelector
			    parent: #( #button #checkable )
			    level: 3) style: [ :sr | " icon border "
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ] ]).

		  ((#( #checkable #'inner-image' #checked ) asToStyleSelector
			    parent: #( #button #checkable #danger )
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

		  ((#( #checkable #'inner-image' #unchecked ) asToStyleSelector
			    parent: #( #button #checkable #danger )
			    level: 3) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 1;
						   yourself ] ]) }
]

{ #category : #'initialization - button' }
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
		  (#button asToStyleSelector style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: BlLinearLayout vertical alignCenter.
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

		  (#button asToStyleSelector - #vertical
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr write: (self property: #padding) with: [ :e |
					   BlInsets
						   top: e toTheme paddingXS / 2
						   left: e toTheme paddingContentHorizontal / 2
						   bottom: e toTheme paddingXS / 2
						   right: e toTheme paddingContentHorizontal / 2 ] ]).

		  (#( #button #vertical ) asToStyleSelector
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr write: (self property: #padding) with: [ :e |
					   BlInsets
						   top: e toTheme paddingContentHorizontal / 2
						   left: e toTheme paddingXS / 2
						   bottom: e toTheme paddingContentHorizontal / 2
						   right: e toTheme paddingXS / 2 ] ]).

		  (#button asToStyleSelector - #vertical - #'no-sizing'
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #height)
					   with: [ :e | e toTheme controlHeight ] ]).

		  (#button asToStyleSelector - #vertical + #'large-sizing'
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #height)
					   with: [ :e | e toTheme controlHeightLG ] ]).

		  (#button asToStyleSelector - #vertical + #'small-sizing'
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #height)
					   with: [ :e | e toTheme controlHeightSM ] ]).

		  ((#'inner-element' asToStyleSelector parent: #button level: 1)
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: BlLinearLayout horizontal.
				   sr write: (self property: #'layout-constraints') with: [ :e |
					   [ :c |
					   c linear vertical alignCenter.
					   c linear horizontal alignCenter ] ] ]).

		  ((#'inner-element' asToStyleSelector
			    parent: #( #button #vertical )
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr write: (self property: #layout) with: BlLinearLayout vertical ]).

		  ((#'inner-element' asToStyleSelector
			    parent: #button asToStyleSelector - #justified
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #'layout-interspace')
				   with: [ :e | e toTheme paddingContentHorizontal / 3 ] ]).

		  ((#'inner-element' asToStyleSelector
			    parent: #( #button #justified )
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr write: (self property: #'layout-interspace') with: [ :e | 0 ].
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal matchParent.
				   c vertical matchParent ] ] ]).

		  ((#'inner-element' asToStyleSelector
			    parent: #( #button #'icon-first' ) asToStyleSelector - #circle
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #'layout-direction')
				   with: [ :e | BlLayoutDirection leftToRight ] ]).

		  ((#'inner-element' asToStyleSelector
			    parent: #( #button #'label-first' )
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #'layout-direction')
				   with: [ :e | BlLayoutDirection rightToLeft ] ]).

		  (#button asToStyleSelector - #circle style: [ :sr |
			   sr write: (self property: #geometry) with: [ :e |
				   BlRoundedRectangleGeometry cornerRadius: e toTheme borderRadius ] ]).

		  (#( #button #round ) asToStyleSelector - #circle
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #geometry)
					   with: [ :e |
					   BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] ]).

		  (#( #button #circle ) asToStyleSelector
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: [ :e | BlFrameLayout new ].
				   sr write: (self property: #padding) with: BlInsets empty.
				   sr
					   write: (self property: #geometry)
					   with: [ :e | BlCircleGeometry new ] ]).

		  ((#'inner-element' asToStyleSelector
			    parent: #( #button #circle )
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlLinearLayout new alignCenter ] ]).

		  ((#'inner-element' asToStyleSelector
			    parent: #( #button ) asToStyleSelector - #justified
			    level: 1) style: [ :sr |
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c frame vertical alignCenter.
				   c frame horizontal alignCenter.
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ] ]).

		  ((self any parent: #( #button ) level: 2) style: [ :sr |
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ] ]) }
]

{ #category : #'initialization - button' }
ToDefaultStyleSheet >> defaultButtonRules [
	" ToButton default rule including icon and label "

	" default button (class #button) "

	^ {
		  (#button asToStyleSelector style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  (#button asToStyleSelector - #checkable style: [ :sr |
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
		  ((#image asToStyleSelector parent: #button level: 2) style: [ :sr |
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
		  ((#label asToStyleSelector parent: #button level: 2) style: [ :sr |
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
		  (#( #button #danger ) asToStyleSelector - #checkable style: [ :sr |
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
		  ((#image asToStyleSelector parent: #( #button #danger ) level: 2)
			   style: [ :sr |
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
		  ((#label asToStyleSelector parent: #( #button #danger ) level: 2)
			   style: [ :sr |
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
		  (#( #dashed ) asToStyleSelector style: [ :sr |
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
	self addButtonRules.
	self addLabelRules
]

{ #category : #'initialization  - label' }
ToDefaultStyleSheet >> labelRules [
	" label  rules"

	^ {
		  ((#label asToStyleSelector or: #( #label #H0 ) ) style: [ :sr |
			   sr
				   write: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   weight: e toTheme fontWeightStrong;
						   defaultFontName: e toTheme fontFamilyCode;
						   defaultFontSize: e toTheme fontSize;
						   lineSpacing: e toTheme lineHeight;
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder foreground:
						   e toTheme colorTextDisabled ] ]).

		  (#( #label #H1 ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading1;
						   lineSpacing: e toTheme lineHeightHeading1;
						   yourself ] ]).
		  (#( #label #H2 ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading2;
						   lineSpacing: e toTheme lineHeightHeading2;
						   yourself ] ]).
		  (#( #label #H3 ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading3;
						   lineSpacing: e toTheme lineHeightHeading3;
						   yourself ] ]).
		  (#( #label #H4 ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading4;
						   lineSpacing: e toTheme lineHeightHeading4;
						   yourself ] ]).
		  (#( #label #H5 ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading5;
						   lineSpacing: e toTheme lineHeightHeading5;
						   yourself ] ]).

		  (#( #label #danger ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorError;
						   yourself ] ]).
		  (#( #label #link ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorLink;
						   yourself ] ]).
		  (#( #label #primary ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorTextLightSolid;
						   yourself ] ]).
		  (#( #label #primary ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorTextSecondary;
						   yourself ] ]).
		  (#( #label #success ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorSuccess;
						   yourself ] ]).
		  (#( #label #warning ) asToStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorWarning;
						   yourself ] ]) }
]

{ #category : #'initialization - button' }
ToDefaultStyleSheet >> linkButtonRules [
	" ToButton link "

	^ {
		  (#( #button #link ) asToStyleSelector
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " ToButton link danger "
		  (#( #button #link #danger ) asToStyleSelector
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " button link form icon "
		  ((#image asToStyleSelector parent: #( #button #link ) level: 2)
			   style: [ :sr |
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
		  ((#label asToStyleSelector parent: #( #button #link ) level: 2)
			   style: [ :sr |
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
		  ((#image asToStyleSelector
			    parent: #( #button #link #danger )
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
		  ((#label asToStyleSelector
			    parent: #( #button #link #danger )
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

{ #category : #'initialization - button' }
ToDefaultStyleSheet >> primaryButtonRules [
	" ToButton primary "

	^ {
		  (#button asToStyleSelector + #primary style: [ :sr |
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
		  (#button asToStyleSelector + #primary + #danger style: [ :sr |
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

		  ((#image asToStyleSelector
			    parent: #button asToStyleSelector + #primary
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

		  ((#label asToStyleSelector
			    parent: #button asToStyleSelector + #primary
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

{ #category : #'initialization - button' }
ToDefaultStyleSheet >> textButtonRules [
	" ToButton text "

	^ {
		  (#( #button #text ) asToStyleSelector style: [ :sr |
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

		  (#( #button #text #danger ) asToStyleSelector style: [ :sr |
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

		  ((#image asToStyleSelector parent: #( #button #text ) level: 2)
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e toTheme colorText ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  " button test label "

		  ((#label asToStyleSelector parent: #( #button #text ) level: 2)
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorText ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  " button text danger form icon "

		  ((#image asToStyleSelector
			    parent: #( #button #text #danger )
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

		  ((#label asToStyleSelector
			    parent: #( #button #text #danger )
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
