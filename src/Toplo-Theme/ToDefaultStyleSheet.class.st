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
			   sr write: (self property: #'border-with-builder') with: [ :e |
				   e borderBuilder
					   paint: (e stampValue: #'color-border-checkable');
					   yourself ].

			   sr select: (sr child: #'inner-image' depth: 3) not style: [
				   sr
					   write: (self property: #iconImage)
					   with: [ :e | (e stampValue: #'checkbox-image-builder') value ] ] ]).

		  " checkbox icon geometry "
		  ((#image asStyleSelector
			    parent: #( #button #checkable #checkbox )
			    depth: 2) style: [ :sr |
			   sr
				   write: (self property: #geometry)
				   with: [ :e | BlRoundedRectangleGeometry cornerRadius: 3 ] ]).

		  " radio button icon geometry "
		  ((#image asStyleSelector
			    parent: #( #button #checkable #radio )
			    depth: 2) style: [ :sr |
			   sr
				   write: (self property: #geometry)
				   with: [ :e | BlCircleGeometry new ] ]).

		  ((#image asStyleSelector parent: #( #button #checkable ) depth: 2)
			   style: [ :sr | " icon border "
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
						   e borderBuilder
							   paint: (e stampValue: #'color-border');
							   yourself ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
						   e borderBuilder
							   paint: (e stampValue: #'color-border-disabled');
							   yourself ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
						   e borderBuilder
							   paint: (e stampValue: #'color-primary-hover');
							   yourself ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
						   e borderBuilder
							   paint: (e stampValue: #'color-primary-pressed');
							   yourself ] ]).

		  ((#image asStyleSelector
			    parent: #( #button #checkable #danger )
			    depth: 2) style: [ :sr | " icon border "
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e stampValue: #'color-error');
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e stampValue: #'color-error-hover');
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e stampValue: #'color-error-pressed');
						   yourself ] ]).

		  (((#'triplet-filler-1' asStyleSelector
			     parent: #( #button #checkable )
			     depth: 2) sibling: #'button-label') style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlFrameLayout new ].

			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal exact: (e stampValue: #'padding-content-H') / 3.
				   c vertical exact: (e stampValue: #'padding-content-H') / 3 ] ].

			   sr select: (sr parent: #justified depth: 2) style: [
				   sr write: (self property: #'layout-constraints') with: [ :e |
					   [ :c |
					   c horizontal matchParent.
					   c vertical matchParent.
					   c minWidth: (e stampValue: #'padding-content-H') / 3.
					   c minHeight: (e stampValue: #'padding-content-H') / 3 ] ] ].

			   sr
				   select:
				   (sr
					    parent: #'interspace-1' asStyleSelector - #vertical
					    depth: 2)
				   style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c horizontal exact: (e stampValue: #'interspace-1') value.
						   c vertical matchParent ] ] ].

			   sr
				   select:
				   (sr
					    parent: #'interspace-1' asStyleSelector + #vertical
					    depth: 2)
				   style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c vertical exact: (e stampValue: #'interspace-1') value.
						   c horizontal matchParent ] ] ] ]) }
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
				   with: [ :e | ((e stampValue: #'control-height')/2) asPoint ].

			   sr write: (self property: #'border-with-builder') with: [ :e |
				   e borderBuilder
					   paint: (e stampValue: #'color-primary');
					   width: 0;
					   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e stampValue: #'color-border-disabled');
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
						   paint: (e stampValue: #'color-error');
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e stampValue: #'color-border-disabled');
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
				   with: [ :e | (e stampValue: #'color-bg-container-disabled') ].
			   sr
				   when: ToIndeterminateLookEvent
				   write: (self property: #background)
				   with: [ :e | (e stampValue: #'color-primary') ].
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
				   with: [ :e | (e stampValue: #'color-error') ] ]) }
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
				   with: [ :e | (e stampValue: #'control-height') ].
				sr
				   write: (self property: #width)
				   with: [ :e | (e stampValue: #'control-height') ]]).
			
		(#(#button #circle) asStyleSelector + #'small-sizing' style: [
			   :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | (e stampValue: #'control-height-SM') ].
				sr
				   write: (self property: #width)
				   with: [ :e | (e stampValue: #'control-height-SM') ] ]).

		(#(#button #circle) asStyleSelector + #'large-sizing' style: [
			   :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | (e stampValue: #'control-height-LG') ].
				sr
				   write: (self property: #width)
				   with: [ :e | (e stampValue: #'control-height-LG') ] ]).
			
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
				   with: BlLinearLayout vertical alignCenter.

			   sr select: #vertical asStyleSelector not style: [
				   sr write: (self property: #padding) with: [ :e |
					   BlInsets
						   top: (e stampValue: #'padding-XS') / 2
						   left: (e stampValue: #'padding-content-H') / 2
						   bottom: (e stampValue: #'padding-XS') / 2
						   right: (e stampValue: #'padding-content-H') / 2 ].

				   sr select: self haveExactHeight not style: [
					   sr
						   write: (self property: #height)
						   with: [ :e | (e stampValue: #'control-height') ] ].

				   sr select: #'large-sizing' style: [
					   sr
						   write: (self property: #height)
						   with: [ :e | (e stampValue: #'control-height-LG') ] ].

				   sr select: #'small-sizing' style: [
					   sr
						   write: (self property: #height)
						   with: [ :e | (e stampValue: #'control-height-SM') ] ] ].

			   " non circular button corner radius"
			   sr select: #circle asStyleSelector not style: [
				   sr write: (self property: #geometry) with: [ :e |
					   BlRoundedRectangleGeometry cornerRadius:
						   (e stampValue: 'border-radius') ].

				   sr select: #round asStyleSelector style: [
					   sr
						   write: (self property: #geometry)
						   with: [ :e |
						   BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] ] ] ]).

		  ((#'inner-element' asStyleSelector parent: #button) style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: BlLinearLayout horizontal.
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal fitContent.
				   c vertical fitContent.
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ].

			   " without justification "
			   sr select: (sr parent: #justified asStyleSelector not) style: [
				   sr write: (self property: #'layout-constraints') with: [ :e |
					   [ :c |
					   c frame vertical alignCenter.
					   c frame horizontal alignCenter.
					   c linear vertical alignCenter.
					   c linear horizontal alignCenter ] ] ].

			   " with justification: 
					innerElement is matchParent if it has a parent with #justified and with #'button-label' and #'button-icon' at depth 1"
			   sr
				   select:
					   (((sr parent: #justified) child: #'button-icon') child:
						    #'button-label')
				   style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c horizontal matchParent.
						   c vertical matchParent ] ] ].

			   sr select: (sr parent: #'icon-first') style: [
				   sr
					   write: (self property: #'layout-direction')
					   with: [ :e | BlLayoutDirection leftToRight ] ].

			   sr select: (sr parent: #'label-first') style: [
				   sr
					   write: (self property: #'layout-direction')
					   with: [ :e | BlLayoutDirection rightToLeft ] ] ]).

		  ((((#'triplet-filler-1' asStyleSelector
			      parent: #( #button )
			      depth: 2) sibling: #'button-label') sibling: #'button-icon')
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: [ :e | BlFrameLayout new ].

				   sr
					   write: (self property: #'layout-constraints')
					   with: [ :e | 
						   [ :c |
						   c horizontal exact: (e stampValue: #'padding-content-H') / 3.
						   c vertical exact: (e stampValue: #'padding-content-H') / 3 ] ].


				   sr select: (sr parent: #justified depth: 2) style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c horizontal matchParent.
						   c vertical matchParent.
						   c minWidth: (e stampValue: #'padding-content-H') / 3.
						   c minHeight: (e stampValue: #'padding-content-H') / 3 ] ] ].

				   sr
					   select:
					   (sr
						    parent: #'interspace-1' asStyleSelector - #vertical
						    depth: 2)
					   style: [
						   sr
							   write: (self property: #'layout-constraints')
							   with: [ :e |
								   [ :c |
								   c horizontal exact: (e stampValue: #'interspace-1') value.
								   c vertical matchParent ] ] ].

				   sr
					   select:
					   (sr
						    parent: #'interspace-1' asStyleSelector + #vertical
						    depth: 2)
					   style: [
						   sr
							   write: (self property: #'layout-constraints')
							   with: [ :e |
								   [ :c |
								   c vertical exact: (e stampValue: #'interspace-1') value.
								   c horizontal matchParent ] ] ] ]).

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
				   with: [ :e | e stampValue: #'color-bg-container-disabled' ] ]).

		  (#button asStyleSelector - #checkable style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e stampValue: #'color-border');
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e stampValue: #'color-border-disabled');
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e stampValue: #'color-primary-hover');
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e stampValue: #'color-primary-pressed');
						   yourself ] ]).

		  " default button form icon "
		  ((#image asStyleSelector parent: #button depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e stampValue: #'color-text' ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e stampValue: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-primary') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-primary-pressed') ] ]).

		  " default button label "
		  ((#label asStyleSelector parent: #button depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e stampValue: #'color-text' ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e stampValue: #'color-text-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e stampValue: #'color-primary') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e stampValue: #'color-primary-pressed') ] ]).

		  " ToButton default danger"
		  (#( #button #danger ) asStyleSelector - #checkable style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: (e stampValue: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: (e stampValue: #'color-border-disabled') ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: (e stampValue: #'color-error-hover') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: (e stampValue: #'color-error-pressed') ] ]).

		  " danger button form icon "
		  ((#image asStyleSelector parent: #( #button #danger ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e stampValue: #'color-error') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e stampValue: #'color-image-disabled') ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e stampValue: #'color-error-hover') ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e stampValue: #'color-error-pressed') ] ]).

		  " danger button label "
		  ((#label asStyleSelector parent: #( #button #danger ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e stampValue: #'color-error') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e stampValue: #'color-text-disabled' ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e stampValue: #'color-error-hover') ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e stampValue: #'color-error-pressed') ] ]).

		  " default button dashed "
		  (#( #dashed ) asStyleSelector style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder dashArray: (e stampValue: #'dash-array') ] ]) } 
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
						   weight: (e stampValue: #'font-weight-strong');
						   defaultFontName: (e stampValue: #'font-family-code');
						   defaultFontSize: (e stampValue: #'font-size');
						   lineSpacing: (e stampValue: #'line-height');
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder foreground:
						   (e stampValue: #'color-text-disabled') ] ]).

		  (#( #label #H1 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e stampValue: #'font-size-H1');
						   lineSpacing: (e stampValue: #'line-height-H1');
						   yourself ] ]).
		  (#( #label #H2 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e stampValue: #'font-size-H2');
						   lineSpacing: (e stampValue: #'line-height-H2');
						   yourself ] ]).
		  (#( #label #H3 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e stampValue: #'font-size-H3');
						   lineSpacing: (e stampValue: #'line-height-H3');
						   yourself ] ]).
		  (#( #label #H4 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e stampValue: #'font-size-H4');
						   lineSpacing: (e stampValue: #'line-height-H4');
						   yourself ] ]).
		  (#( #label #H5 ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e stampValue: #'font-size-H5');
						   lineSpacing: (e stampValue: #'line-height-H5');
						   yourself ] ]).

		  (#( #label #danger ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e stampValue: #'color-error');
						   yourself ] ]).
		  (#( #label #link ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e stampValue: #'color-link');
						   yourself ] ]).
		  (#( #label #primary ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e stampValue: #'color-text-light-solid');
						   yourself ] ]).
		  (#( #label #primary ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e stampValue: #'color-text-secondary');
						   yourself ] ]).
		  (#( #label #success ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e stampValue: #'color-success');
						   yourself ] ]).
		  (#( #label #warning ) asStyleSelector style: [ :sr |
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e stampValue: #'color-warning');
						   yourself ] ]) }
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> linkButtonRules [
	" ToButton link "

	^ {
		  (#( #button #link ) asStyleSelector style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder width: 0 ] ]).

		  " ToButton link danger "
		  (#( #button #link #danger ) asStyleSelector style: [ :sr |
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
					   with: [ :e | (e stampValue: #'color-link') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e stampValue: #'color-text-disabled' ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e stampValue: #'color-link-hover'  ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e stampValue: #'color-primary-pressed') ] ]).

		  " button link label "
		  ((#label asStyleSelector parent: #( #button #link ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e stampValue: #'color-link') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e stampValue: #'color-text-disabled' ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e stampValue: #'color-link-hover') ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e stampValue: #'color-primary-pressed') ] ]).

		  " button link danger form icon "
		  ((#image asStyleSelector
			    parent: #( #button #link #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e stampValue: #'color-text-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-error-hover') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-error-pressed') ] ]).

		  " button link danger label "
		  ((#label asStyleSelector
			    parent: #( #button #link #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e stampValue: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e stampValue: #'color-text-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e stampValue: #'color-error-hover') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e stampValue: #'color-error-pressed') ] ]) }
]

{ #category : #'accessing rules  -button' }
ToDefaultStyleSheet >> primaryButtonRules [
	" ToButton primary "

	^ {
		  (#button asStyleSelector + #primary style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #background)
				   with: [ :e | (e stampValue: #'color-primary') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e stampValue: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | (e stampValue: #'color-primary-hover') ]
				   animation: ToPropertyColorTransitionAnimation new.
			   sr
				   when: ToLeavedLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | (e stampValue: #'color-primary') ]
				   animation: ToPropertyColorTransitionAnimation new.
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | (e stampValue: #'color-primary-pressed') ].

			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: (e stampValue: #'color-border-disabled') ].


			   sr select: #danger style: [
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #background)
					   with: [ :e | (e stampValue: #'color-error') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #background)
					   with: [ :e | e stampValue: #'color-bg-container-disabled' ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'background-color')
					   with: [ :e | (e stampValue: #'color-error-hover') ]
					   animation: ToPropertyColorTransitionAnimation new.
				   sr
					   when: ToLeavedLookEvent
					   write: (self property: #'background-color')
					   with: [ :e | (e stampValue: #'color-error') ]
					   animation: ToPropertyColorTransitionAnimation new.
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #background)
					   with: [ :e | e stampValue: #'color-error-pressed' ].

				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder paint: Color transparent ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
					   e borderBuilder paint: (e stampValue: #'color-border-disabled') ] ] ]).

		  " primary button form icon "

		  ((#image asStyleSelector
			    parent: #button asStyleSelector + #primary
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-image-light-solid') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-image-disabled') ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-image-light-solid') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-image-light-solid') ] ]).

		  " primary button label "

		  ((#label asStyleSelector
			    parent: #button asStyleSelector + #primary
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e stampValue: #'color-text-light-solid') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e stampValue: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e stampValue: #'color-text-light-solid') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e stampValue: #'color-text-light-solid') ] ]) }
]

{ #category : #'accessing rules  - pane' }
ToDefaultStyleSheet >> rootPaneRules [

	^ { ((self id: #'Space root') style: [ :sr |
		   sr
			   write: (self property: #background)
			   with: [ :e | e stampValue: #'background-color' ] ]) }
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
				   with: [ :e | e stampValue: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #background)
				   with: [ :e | e stampValue: #'color-bg-text-hover' ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | e stampValue: #'color-bg-text-active' ].

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
				   with: [ :e | e stampValue: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #background)
				   with: [ :e | e stampValue: #'color-error-bg' ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | e stampValue: #'color-error-bg' ].

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
					   with: [ :e | e stampValue: #'color-text' ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e stampValue: #'color-bg-container-disabled' ] ]).

		  " button test label "

		  ((#label asStyleSelector parent: #( #button #text ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e stampValue: #'color-text' ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e stampValue: #'color-bg-container-disabled' ] ]).

		  " button text danger form icon "

		  ((#image asStyleSelector
			    parent: #( #button #text #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e stampValue: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e stampValue: #'color-bg-container-disabled' ] ]).

		  " button test danger label "

		  ((#label asStyleSelector
			    parent: #( #button #text #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInitialLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e stampValue: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e stampValue: #'color-bg-container-disabled' ] ]) }
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
					   top: (e stampValue: #'padding-content-H') / 2
					   left: (e stampValue: #'padding-XS') / 2
					   bottom: (e stampValue: #'padding-content-H') / 2
					   right: (e stampValue: #'padding-XS') / 2 ].

			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ] ]).

		  ((#'inner-element' asStyleSelector parent: #( #button #vertical ))
			   style: [ :sr |
				   sr
					   when: ToInitialLookEvent
					   write: (self property: #layout)
					   with: BlLinearLayout vertical ]) }
]
