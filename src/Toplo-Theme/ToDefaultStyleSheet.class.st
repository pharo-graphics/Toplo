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
		  (#( #button #checkable ) asToTag style: [ :sr |
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
		  ((#image asToTag
			    parent: #( #button #checkable #checkbox ) asToTag
			    level: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #geometry)
				   with: [ :e | BlRoundedRectangleGeometry cornerRadius: 3 ] ]).

		  " radio button icon geometry "
		  ((#image asToTag
			    parent: #( #button #checkable #radio ) asToTag
			    level: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #geometry)
				   with: [ :e | BlCircleGeometry new ] ]).

		  ((#image asToTag parent: #( #button #checkable ) asToTag level: 2)
			   style: [ :sr | " icon border "
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

		  ((#image asToTag
			    parent: #( #button #checkable #danger ) asToTag
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
		  ((#( #checkable #'inner-image' ) asToTag
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

		  ((#( #checkable #'inner-image' #indeterminate #bar ) asToTag
			    parent: (#( #checkable #'inner-image' ) asToTag
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

		  ((#( #checkable #'inner-image' #indeterminate #bar ) asToTag
			    parent: (#( #checkable #'inner-image' ) asToTag
					     parent: #( #button #checkable #danger )
					     level: 3)
			    level: 1) style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: [ :e | e toTheme colorError ] ]).

		  ((#( #checkable #'inner-image' #indeterminate ) asToTag
			    parent: #( #button #checkable )
			    level: 4) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #margin)
				   with: [ :e | BlInsets all: 2 ] ]).

		  ((#( #checkable #'inner-image' #checked ) asToTag
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

		  ((#( #checkable #'inner-image' #unchecked ) asToTag
			    parent: #( #button #checkable )
			    level: 3) style: [ :sr | " icon border "
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ] ]).

		  ((#( #checkable #'inner-image' #checked ) asToTag
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

		  ((#( #checkable #'inner-image' #unchecked ) asToTag
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
		  (#button asToTag style: [ :sr |
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

		  (#button asToTag - #vertical asToTag
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr write: (self property: #padding) with: [ :e |
					   BlInsets
						   top: e toTheme paddingXS / 2
						   left: e toTheme paddingContentHorizontal / 2
						   bottom: e toTheme paddingXS / 2
						   right: e toTheme paddingContentHorizontal / 2 ] ]).

		  (#( #button #vertical ) asToTag
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr write: (self property: #padding) with: [ :e |
					   BlInsets
						   top: e toTheme paddingContentHorizontal / 2
						   left: e toTheme paddingXS / 2
						   bottom: e toTheme paddingContentHorizontal / 2
						   right: e toTheme paddingXS / 2 ] ]).

		  (#button asToTag - #vertical asToTag - #'no-sizing' asToTag
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #height)
					   with: [ :e | e toTheme controlHeight ] ]).

		  (#button asToTag - #vertical asToTag + #'large-sizing' asToTag
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #height)
					   with: [ :e | e toTheme controlHeightLG ] ]).

		  (#button asToTag - #vertical asToTag + #'small-sizing' asToTag
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #height)
					   with: [ :e | e toTheme controlHeightSM ] ]).

		  ((#'inner-element' asToTag parent: #button asToTag level: 1)
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: BlLinearLayout horizontal.
				   sr write: (self property: #'layout-constraints') with: [ :e |
					   [ :c |
					   c linear vertical alignCenter.
					   c linear horizontal alignCenter ] ] ]).

		  ((#'inner-element' asToTag
			    parent: #( #button #vertical ) asToTag
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr write: (self property: #layout) with: BlLinearLayout vertical ]).

		  ((#'inner-element' asToTag
			    parent: #( #button ) asToTag - #justified asToTag
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #'layout-interspace')
				   with: [ :e | e toTheme paddingContentHorizontal / 3 ] ]).

		  ((#'inner-element' asToTag
			    parent: #( #button #justified ) asToTag
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr write: (self property: #'layout-interspace') with: [ :e | 0 ].
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal matchParent.
				   c vertical matchParent ] ] ]).

		  ((#'inner-element' asToTag
			    parent: #( #button #'icon-first' ) asToTag - #circle asToTag
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #'layout-direction')
				   with: [ :e | BlLayoutDirection leftToRight ] ]).

		  ((#'inner-element' asToTag
			    parent: #( #button #'label-first' ) asToTag
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #'layout-direction')
				   with: [ :e | BlLayoutDirection rightToLeft ] ]).

		  (#button asToTag - #circle asToTag style: [ :sr |
			   sr write: (self property: #geometry) with: [ :e |
				   BlRoundedRectangleGeometry cornerRadius: e toTheme borderRadius ] ]).

		  (#( #button #round ) asToTag - #circle asToTag
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #geometry)
					   with: [ :e |
					   BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] ]).

		  (#( #button #circle ) asToTag
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: [ :e | BlFrameLayout new ].
				   sr write: (self property: #padding) with: BlInsets empty.
				   sr
					   write: (self property: #geometry)
					   with: [ :e | BlCircleGeometry new ] ]).

		  ((#'inner-element' asToTag
			    parent: #( #button #circle ) asToTag
			    level: 1) when: ToInstallLookEvent style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlLinearLayout new alignCenter ] ]).

		  ((#'inner-element' asToTag
			    parent: #( #button ) asToTag - #justified asToTag
			    level: 1) style: [ :sr |
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c frame vertical alignCenter.
				   c frame horizontal alignCenter.
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ] ]).

		  ((self any parent: #( #button ) asToTag level: 2) style: [ :sr |
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
		  (#button asToTag style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  (#button asToTag - #checkable  style: [ :sr |
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
		  ((#image asToTag parent: #button asToTag level: 2) style: [ :sr |
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
		  ((#label asToTag parent: #button asToTag level: 2) style: [ :sr |
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
		  (#( #button #danger ) asToTag - #checkable  style: [ :sr |
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
		  ((#image asToTag parent: #( #button #danger ) asToTag level: 2)
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
		  ((#label asToTag parent: #( #button #danger ) asToTag level: 2)
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
		  (#( #dashed ) asToTag style: [ :sr |
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
		  ((#label asToTag or: #( #label #H0 ) asToTag) style: [ :sr |
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

		  (#( #label #H1 ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading1;
						   lineSpacing: e toTheme lineHeightHeading1;
						   yourself ] ]).
		  (#( #label #H2 ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading2;
						   lineSpacing: e toTheme lineHeightHeading2;
						   yourself ] ]).
		  (#( #label #H3 ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading3;
						   lineSpacing: e toTheme lineHeightHeading3;
						   yourself ] ]).
		  (#( #label #H4 ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading4;
						   lineSpacing: e toTheme lineHeightHeading4;
						   yourself ] ]).
		  (#( #label #H5 ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading5;
						   lineSpacing: e toTheme lineHeightHeading5;
						   yourself ] ]).

		  (#( #label #danger ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorError;
						   yourself ] ]).
		  (#( #label #link ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorLink;
						   yourself ] ]).
		  (#( #label #primary ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorTextLightSolid;
						   yourself ] ]).
		  (#( #label #primary ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorTextSecondary;
						   yourself ] ]).
		  (#( #label #success ) asToTag style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorSuccess;
						   yourself ] ]).
		  (#( #label #warning ) asToTag style: [ :sr |
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
		  (#( #button #link ) asToTag
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " ToButton link danger "
		  (#( #button #link #danger ) asToTag
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " button link form icon "
		  ((#image asToTag parent: #( #button #link ) asToTag level: 2)
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
		  ((#label asToTag parent: #( #button #link ) asToTag level: 2)
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
		  ((#image asToTag
			    parent: #( #button #link #danger ) asToTag
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
		  ((#label asToTag
			    parent: #( #button #link #danger ) asToTag
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
		  (#button asToTag + #primary asToTag style: [ :sr |
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
		  (#button asToTag + #primary asToTag + #danger asToTag style: [
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

		  ((#image asToTag
			    parent: #button asToTag + #primary asToTag
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

		  ((#label asToTag
			    parent: #button asToTag + #primary asToTag
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
		  (#( #button #text ) asToTag style: [ :sr |
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

		  (#( #button #text #danger ) asToTag style: [ :sr |
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

		  ((#image asToTag parent: #( #button #text ) asToTag level: 2)
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

		  ((#label asToTag parent: #( #button #text ) asToTag level: 2)
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

		  ((#image asToTag
			    parent: #( #button #text #danger ) asToTag
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

		  ((#label asToTag
			    parent: #( #button #text #danger ) asToTag
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
