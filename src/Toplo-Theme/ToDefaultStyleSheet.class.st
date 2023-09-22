Class {
	#name : #ToDefaultStyleSheet,
	#superclass : #ToStyleSheet,
	#category : #'Toplo-Theme-DefaultTheme'
}

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> buttonRules [

	^ Array streamContents: [ :str |
		  str nextPutAll: self commonButtonRules.
		  str nextPutAll: self defaultButtonRules.
		  str nextPutAll: self primaryButtonRules.
		  str nextPutAll: self textButtonRules.
		  str nextPutAll: self linkButtonRules.
		  str nextPutAll: self checkableButtonRules.
		  str nextPutAll: self checkableInnerImageRules.
		  str nextPutAll: self circleButtonRules.
		  str nextPutAll: self verticalButtonRules.
		  str nextPutAll: self toggleButtonRules ]
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> checkableButtonRules [
	" checkbox family "

	^ {
		  (#( #button #checkable ) asStyleSelector style: [ :sr |   
				sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorderCheckable;
						   yourself ] ]).

		  " checkbox icon geometry "
		  ((#image asStyleSelector
			    parent: #( #button #checkable #checkbox )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #geometry)
				   with: [ :e | BlRoundedRectangleGeometry cornerRadius: 3 ] ]).

		  " radio button icon geometry "
		  ((#image asStyleSelector
			    parent: #( #button #checkable #radio )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #geometry)
				   with: [ :e | BlCircleGeometry new ] ]).

		  ((#image asStyleSelector parent: #( #button #checkable ) depth: 2)
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

		  ((#image asStyleSelector
			    parent: #( #button #checkable #danger )
			    depth: 2) style: [ :sr | " icon border "
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorError;
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

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> checkableInnerImageRules [
	" checkbox family "

	^ {
		  ((#( #'inner-image' ) asStyleSelector
			    parent: #( #button #checkable )
			    depth: 3) style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlFrameLayout new ].
			   sr
				   write: (self property: #size)
				   with: [ :e | (e toTheme controlHeight / 2) asPoint ].

			   sr write: (self property: #'border-with-builder') with: [ :e |
				   e borderBuilder
					   paint: e toTheme colorPrimary;
					   width: 0;
					   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorderDisabled;
						   yourself ].
			   sr
				   when: ToCheckedLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 6;
						   yourself ].
			   sr
				   when: ToUncheckedLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ].
			   sr
				   when: ToIndeterminateLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ] ]).

		  ((#( #'inner-image' ) asStyleSelector
			    parent: #( #button #checkable #danger )
			    depth: 3) style: [ :sr |
			   sr
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorError;
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: e toTheme colorBorderDisabled;
						   yourself ] ]).

		  ((#bar asStyleSelector
			    parent: (#( #'inner-image' ) asStyleSelector
					     parent: #( #button #checkable )
					     depth: 3)
			    depth: 1) style: [ :sr |
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal matchParent.
				   c vertical exact: 4.
				   c frame horizontal alignCenter.
				   c frame vertical alignCenter ] ].
			   sr
				   write: (self property: #margin)
				   with: [ :e | BlInsets left: 2 right: 2 ].

			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ].
			   sr
				   when: ToIndeterminateLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorPrimary ].
			   sr
				   when: ToCheckedLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToUncheckedLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ] ]).

		  ((#bar asStyleSelector
			    parent: (#( #'inner-image' ) asStyleSelector
					     parent: #( #button #checkable #danger )
					     depth: 3)
			    depth: 1) style: [ :sr |
			   sr
				   when: ToIndeterminateLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorError ] ]) }
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> circleButtonRules [


	^ {

		  (#( #button #circle ) asStyleSelector style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlFrameLayout new ].
			   sr write: (self property: #padding) with: BlInsets empty.
			   sr
				   write: (self property: #geometry)
				   with: [ :e | BlCircleGeometry new ] ]).
			
		(#(#button #circle) asStyleSelector - self haveExactHeight style: [ :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | e toTheme controlHeight ].
				sr
				   write: (self property: #width)
				   with: [ :e | e toTheme controlHeight ]]).
			
		(#(#button #circle) asStyleSelector + #'small-sizing' style: [
			   :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | e toTheme controlHeightSM ].
				sr
				   write: (self property: #width)
				   with: [ :e | e toTheme controlHeightSM ] ]).

		(#(#button #circle) asStyleSelector + #'large-sizing' style: [
			   :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | e toTheme controlHeightLG ].
				sr
				   write: (self property: #width)
				   with: [ :e | e toTheme controlHeightLG ] ]).
			
		((#'inner-element' asStyleSelector parent: #( #button #circle ))
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: [ :e | BlLinearLayout new alignCenter ] ]) }
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> commonButtonRules [
	"  
	'button:hover' rule: [ :e | e mouseCursor: BlCursor hand. e background: Color gray. e font-size: 18 ].
	'button:leave' rule: [ :e | e mouseCursor: nil ].

	'button' rule: [ :e | e background: Color white ].
	'button:hover' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].
	'button:hover, button:leave' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].
	"

	^ {
		  (#button asStyleSelector style: [ :sr |
				
				sr rules: {  }.
			
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
				   with: nil.
			
			   sr
				   write: (self property: #layout)
				   with: BlLinearLayout vertical alignCenter ] ).

		  (#button asStyleSelector - #vertical style: [ :sr |
			   sr write: (self property: #padding) with: [ :e |
				   BlInsets
					   top: e toTheme paddingXS / 2
					   left: e toTheme paddingContentHorizontal / 2
					   bottom: e toTheme paddingXS / 2
					   right: e toTheme paddingContentHorizontal / 2 ] ]).

		  (#button asStyleSelector - #vertical - self haveExactHeight
			   style: [ :sr |
				   sr
					   write: (self property: #height)
					   with: [ :e | e toTheme controlHeight ] ]).

		  (#button asStyleSelector - #vertical + #'large-sizing' style: [
			   :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | e toTheme controlHeightLG ] ]).

		  (#button asStyleSelector - #vertical + #'small-sizing' style: [
			   :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | e toTheme controlHeightSM ] ]).

		  ((#'inner-element' asStyleSelector parent: #button) style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: BlLinearLayout horizontal.
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
					c horizontal fitContent.
					c vertical fitContent.
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ] ]).

		  " innerElement layout interspace is always zero "
		  ((#'inner-element' asStyleSelector parent: #button asStyleSelector)
			   style: [ :sr |
				   sr
					   write: (self property: #'layout-interspace')
					   with: [ :e | 0 ] ]).

		  " innerElement is matchParent if it has a parent with #button and #justified and with #'button-label' and #'button-icon' at depth 2"
		  ((#'inner-element' asStyleSelector parent:
			    ((#( #button #justified ) asStyleSelector
				      child: #'button-label'
				      depth: 2) child: #'button-icon' depth: 2)) style: [ :sr |
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal matchParent.
				   c vertical matchParent ] ] ]).

		  ((#'inner-element' asStyleSelector parent:
			    #( #button #'icon-first' ) asStyleSelector) style: [ :sr |
			   sr
				   write: (self property: #'layout-direction')
				   with: [ :e | BlLayoutDirection leftToRight ] ]).

		  ((#'inner-element' asStyleSelector parent:
			    #( #button #'label-first' ) asStyleSelector) style: [ :sr |
			   sr
				   write: (self property: #'layout-direction')
				   with: [ :e | BlLayoutDirection rightToLeft ] ]).

		  (#button asStyleSelector - #circle style: [ :sr |
			   sr write: (self property: #geometry) with: [ :e |
				   BlRoundedRectangleGeometry cornerRadius: e toTheme borderRadius ] ]).

		  (#( #button #round ) asStyleSelector - #circle style: [ :sr |
			   sr
				   write: (self property: #geometry)
				   with: [ :e |
				   BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] ]).

		  ((#'inner-element' asStyleSelector parent:
			    #( #button ) asStyleSelector - #justified) style: [ :sr |
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c frame vertical alignCenter.
				   c frame horizontal alignCenter.
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ] ]).

		  ((((#'triplet-filler-1' asStyleSelector parent: #( #button ) depth: 2) sibling: #'button-label') sibling: #'button-icon')
			   style: [ :sr |
					sr
					   write: (self property: #layout)
					   with: [ :e | BlFrameLayout new ].
					
				   sr write: (self property: #'layout-constraints') with: [ :e |
					   [ :c | 
					   c horizontal exact: e toTheme paddingContentHorizontal / 3.
					   c vertical exact: e toTheme paddingContentHorizontal / 3 ] ] ]).

		  ((((#'triplet-filler-1' asStyleSelector
			      parent: #( #button #justified )
			      depth: 2) sibling: #'button-label') sibling: #'button-icon')
			   style: [ :sr |
				   sr write: (self property: #'layout-constraints') with: [ :e |
					   [ :c |
					   c horizontal matchParent.
					   c vertical matchParent.
					   c minWidth: e toTheme paddingContentHorizontal / 3.
					   c minHeight: e toTheme paddingContentHorizontal / 3 ] ] ]).

		  ((self any - #'triplet-filler-1' parent: #( #button ) depth: 2)
			   style: [ :sr |
				   sr write: (self property: #'layout-constraints') with: [ :e |
					   [ :c |
					   c linear vertical alignCenter.
					   c linear horizontal alignCenter ] ] ]) }
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> defaultButtonRules [
	" ToButton default rule including icon and label "

	" default button (class #button) "

	^ 
		{ 
			  (#button asStyleSelector style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  (#button asStyleSelector - #checkable style: [ :sr |
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
		  ((#image asStyleSelector parent: #button depth: 2) style: [ :sr |
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
		  ((#label asStyleSelector parent: #button depth: 2) style: [ :sr |
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
		  (#( #button #danger ) asStyleSelector - #checkable style: [ :sr |
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
		  ((#image asStyleSelector parent: #( #button #danger ) depth: 2)
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
		  ((#label asStyleSelector parent: #( #button #danger ) depth: 2)
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
		  (#( #dashed ) asStyleSelector style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder dashArray: e toTheme dashArray ] ]) } 
]

{ #category : #initialization }
ToDefaultStyleSheet >> defaultStyleRules [

	^ Array streamContents: [ :str |
		str nextPutAll: self rootPaneRules.
		str nextPutAll: self buttonRules.
		str nextPutAll: self labelRules ]
]

{ #category : #'accessing rules  - label' }
ToDefaultStyleSheet >> labelRules [
	" label  rules"

	^ {
		  ((#label asStyleSelector or: #( #label #H0 )) style: [ :sr |
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

		  (#( #label #H1 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading1;
						   lineSpacing: e toTheme lineHeightHeading1;
						   yourself ] ]).
		  (#( #label #H2 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading2;
						   lineSpacing: e toTheme lineHeightHeading2;
						   yourself ] ]).
		  (#( #label #H3 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading3;
						   lineSpacing: e toTheme lineHeightHeading3;
						   yourself ] ]).
		  (#( #label #H4 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading4;
						   lineSpacing: e toTheme lineHeightHeading4;
						   yourself ] ]).
		  (#( #label #H5 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: e toTheme fontSizeHeading5;
						   lineSpacing: e toTheme lineHeightHeading5;
						   yourself ] ]).

		  (#( #label #danger ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorError;
						   yourself ] ]).
		  (#( #label #link ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorLink;
						   yourself ] ]).
		  (#( #label #primary ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorTextLightSolid;
						   yourself ] ]).
		  (#( #label #primary ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorTextSecondary;
						   yourself ] ]).
		  (#( #label #success ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorSuccess;
						   yourself ] ]).
		  (#( #label #warning ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: e toTheme colorWarning;
						   yourself ] ]) }
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> linkButtonRules [
	" ToButton link "

	^ 
	  {			  (#( #button #link ) asStyleSelector
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " ToButton link danger "
		  (#( #button #link #danger ) asStyleSelector
			   when: ToInstallLookEvent
			   style: [ :sr |
				   sr
					   write: (self property: #background)
					   with: [ :e | Color transparent ].
				   sr
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder width: 0 ] ]).

		  " button link form icon "
		  ((#image asStyleSelector parent: #( #button #link ) depth: 2)
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
		  ((#label asStyleSelector parent: #( #button #link ) depth: 2)
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
		  ((#image asStyleSelector
			    parent: #( #button #link #danger )
			    depth: 2) style: [ :sr |
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
		  ((#label asStyleSelector
			    parent: #( #button #link #danger )
			    depth: 2) style: [ :sr |
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

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> primaryButtonRules [
	" ToButton primary "

	^
	  {			  (#button asStyleSelector + #primary style: [ :sr |
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
		  (#button asStyleSelector + #primary + #danger style: [ :sr |
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

		  ((#image asStyleSelector
			    parent: #button asStyleSelector + #primary
			    depth: 2) style: [ :sr |
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

		  ((#label asStyleSelector
			    parent: #button asStyleSelector + #primary
			    depth: 2) style: [ :sr |
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

{ #category : #'accessing rules  - pane' }
ToDefaultStyleSheet >> rootPaneRules [

	^ { ((self id: #'Space root')
		   when: ToInstallLookEvent
		   style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: [ :e | e toTheme backgroundColor ] ]) }
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> textButtonRules [
	" ToButton text "

	^ {
		  (#( #button #text ) asStyleSelector style: [ :sr |
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

		  (#( #button #text #danger ) asStyleSelector style: [ :sr |
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

		  ((#image asStyleSelector parent: #( #button #text ) depth: 2)
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

		  ((#label asStyleSelector parent: #( #button #text ) depth: 2)
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

		  ((#image asStyleSelector
			    parent: #( #button #text #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorError ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]).

		  " button test danger label "

		  ((#label asStyleSelector
			    parent: #( #button #text #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorError ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e toTheme colorBgContainerDisabled ] ]) }
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> toggleButtonRules [

	^ { ( #(#button #'toggle-button') asStyleSelector style: [ :sr |
		   sr
			   write: (self property: #background)
			   with: [ :e | Color transparent ].
			sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ].
			
		
		
		
		
				] ) }
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> verticalButtonRules [
	"  
	'button:hover' rule: [ :e | e mouseCursor: BlCursor hand. e background: Color gray. e font-size: 18 ].
	'button:leave' rule: [ :e | e mouseCursor: nil ].

	'button' rule: [ :e | e background: Color white ].
	'button:hover' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].
	'button:hover, button:leave' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].
	"

	^ {

		  (#( #button #vertical ) asStyleSelector style: [ :sr |
			   sr write: (self property: #padding) with: [ :e |
				   BlInsets
					   top: e toTheme paddingContentHorizontal / 2
					   left: e toTheme paddingXS / 2
					   bottom: e toTheme paddingContentHorizontal / 2
					   right: e toTheme paddingXS / 2 ] ]).

		  ((#'inner-element' asStyleSelector parent: #( #button #vertical ))
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: BlLinearLayout vertical ]) }
]
