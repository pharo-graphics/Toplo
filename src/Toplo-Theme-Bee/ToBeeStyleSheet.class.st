Class {
	#name : #ToBeeStyleSheet,
	#superclass : #ToStyleSheet,
	#category : #'Toplo-Theme-Bee'
}

{ #category : #testing }
ToBeeStyleSheet class >> isDeprecated [ 

	^ true
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> buttonRules [
	<script:'(ToStyleSheetCSSLikePrinter styleRules: (self new buttonRules)) asCSSLikeString inspect'>
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ Array streamContents: [ :str |
		
		"Style common for all buttons"
		str nextPutAll: self commonButtonRulesNew.

		"Available button skins"
		str nextPutAll: self defaultButtonRules.
		str nextPutAll: self primaryButtonRules.
		"str nextPutAll: self textButtonRules.
		str nextPutAll: self linkButtonRules."

		"str nextPutAll: self checkableButtonRules.
		str nextPutAll: self checkableInnerImageRules."

		"str nextPutAll: self circleButtonRules.
		str nextPutAll: self verticalButtonRules."

		"str nextPutAll: self toggleButtonRules" ]
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> checkableButtonRules [
	" checkbox family "
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		  (#( #button #checkable ) asStampSelector style: [ :sr |
			   (#checkbox asStampSelector or: #radio asStampSelector) style: [
				   sr write: (self property: #'border-with-builder') with: [ :e |
					   e borderBuilder
						   width: 1;
						   paint: (e valueOfTokenNamed: #'color-border-checkable');
						   yourself ].
				   sr
					   write: (self property: #iconImage)
					   with: [ :e | (e valueOfTokenNamed: #'checkbox-image-builder') value ] ] ]).

		  " checkbox icon geometry "
		  ((#image asStampSelector
			    parent: #( #button #checkable #checkbox )
			    depth: 3) style: [ :sr |
			   sr
				   write: (self property: #geometry)
				   with: [ :e | BlRoundedRectangleGeometry cornerRadius: 3 ] ]).

		  " radio button icon geometry "
		  ((#image asStampSelector
			    parent: #( #button #checkable #radio )
			    depth: 3) style: [ :sr |
			   sr
				   write: (self property: #geometry)
				   with: [ :e | BlCircleGeometry new ] ]).

		  ((#image asStampSelector parent: #( #button #checkable ) depth: 3)
			   style: [ :sr | " icon border "
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
						   e borderBuilder
							   paint: (e valueOfTokenNamed: #'color-border');
							   yourself ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
						   e borderBuilder
							   paint: (e valueOfTokenNamed: #'color-border-disabled');
							   yourself ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
						   e borderBuilder
							   paint: (e valueOfTokenNamed: #'color-primary-hover');
							   yourself ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
						   e borderBuilder
							   paint: (e valueOfTokenNamed: #'color-primary-pressed');
							   yourself ] ]).

		  ((#image asStampSelector
			    parent: #( #button #checkable #danger )
			    depth: 3) style: [ :sr | " icon border "
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-error');
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-error-hover');
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-error-pressed');
						   yourself ] ]).

		  (((#filler asStampSelector
			     parent: #( #button #checkable )
			     depth: 2) sibling: #'button-label') style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlFrameLayout new ].

			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal exact: (e valueOfTokenNamed: #'padding-content-H') / 3.
				   c vertical exact: (e valueOfTokenNamed: #'padding-content-H') / 3 ] ].

			   sr select: (sr parent: #justified depth: 2) style: [
				   sr write: (self property: #'layout-constraints') with: [ :e |
					   [ :c |
					   c horizontal matchParent.
					   c vertical matchParent.
					   c minWidth: (e valueOfTokenNamed: #'padding-content-H') / 3.
					   c minHeight: (e valueOfTokenNamed: #'padding-content-H') / 3 ] ] ].

			   sr
				   select:
				   (sr
					    parent: #'interspace-1' asStampSelector - #vertical
					    depth: 2)
				   style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c horizontal exact: (e valueOfTokenNamed: #'interspace-1') value.
						   c vertical matchParent ] ] ].

			   sr
				   select:
				   (sr
					    parent: #'interspace-1' asStampSelector + #vertical
					    depth: 2)
				   style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c vertical exact: (e valueOfTokenNamed: #'interspace-1') value.
						   c horizontal matchParent ] ] ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> checkableInnerImageRules [
	" checkbox family "
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		  ((#( #'inner-image' ) asStampSelector
			    parent: #( #button #checkable )
			    depth: 4) style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlFrameLayout new ].
			   sr
				   write: (self property: #size)
				   with: [ :e | ((e valueOfTokenNamed: #'control-height') / 2) asPoint ].

			   sr write: (self property: #'border-with-builder') with: [ :e |
				   | width btn |
				   btn := e parent parent parent parent.
				   width := btn checked ifNil: [ 0 ] ifNotNil: [ :c |
					            c
						            ifTrue: [ 6 ]
						            ifFalse: [ 0 ] ].
				   e borderBuilder
					   paint: (e valueOfTokenNamed: #'color-primary');
					   width: width;
					   yourself ].

			   sr
				   when: ToDisabledLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-border-disabled');
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

		  ((#( #'inner-image' ) asStampSelector
			    parent: #( #button #checkable #danger )
			    depth: 4) style: [ :sr |
			   sr
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-error');
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-border-disabled');
						   yourself ] ]).

		  ((#bar asStampSelector
			    parent: (#( #'inner-image' ) asStampSelector
					     parent: #( #button #checkable )
					     depth: 4)
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
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
			   sr
				   when: ToIndeterminateLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-primary' ].
			   sr
				   when: ToCheckedLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToUncheckedLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ] ]).

		  ((#bar asStampSelector
			    parent: (#( #'inner-image' ) asStampSelector
					     parent: #( #button #checkable #danger )
					     depth: 3)
			    depth: 1) style: [ :sr |
			   sr
				   when: ToIndeterminateLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-error' ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> circleButtonRules [

	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {

		  (#( #button #circle ) asStampSelector style: [ :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlFrameLayout new ].
			   sr write: (self property: #padding) with: BlInsets empty.
			   sr
				   write: (self property: #geometry)
				   with: [ :e | BlCircleGeometry new ] ]).
			
		(#(#button #circle) asStampSelector - self haveExactHeight style: [ :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | (e valueOfTokenNamed: #'control-height') ].
				sr
				   write: (self property: #width)
				   with: [ :e | (e valueOfTokenNamed: #'control-height') ]]).
			
		(#(#button #circle) asStampSelector + #'small-sizing' style: [
			   :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | (e valueOfTokenNamed: #'control-height-SM') ].
				sr
				   write: (self property: #width)
				   with: [ :e | (e valueOfTokenNamed: #'control-height-SM') ] ]).

		(#(#button #circle) asStampSelector + #'large-sizing' style: [
			   :sr |
			   sr
				   write: (self property: #height)
				   with: [ :e | (e valueOfTokenNamed: #'control-height-LG') ].
				sr
				   write: (self property: #width)
				   with: [ :e | (e valueOfTokenNamed: #'control-height-LG') ] ]).
			
		((#'inner-element' asStampSelector parent: #( #button #circle ))
			   style: [ :sr |
				   sr
					   write: (self property: #layout)
					   with: [ :e | BlLinearLayout new alignCenter ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> commonButtonRules [

	<script:
	'(ToStyleSheetCSSLikePrinter styleRules: (self new commonButtonRules)) asCSSLikeString inspect'>
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		  (self buttonSelector style: [ :sr | "Mouse cursor management"
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #mouseCursor)
				   with: [ :e |
					   e isEnabled
						   ifTrue: [ Cursor webLink ]
						   ifFalse: [ Cursor crossHair ] ].
			   sr
				   when: ToLeavedLookEvent
				   write: (self property: #mouseCursor)
				   with: nil.

			   "Geometry management"
			   sr write: (self property: #geometry) with: [ :e |
				   BlRoundedRectangleGeometry cornerRadius:
					   (e valueOfTokenNamed: 'border-radius') ].

			   "Size management"
			   sr write: (self property: #padding) with: [ :e |
				   BlInsets
					   top: (e valueOfTokenNamed: #'padding-content-V')
					   left: (e valueOfTokenNamed: #'padding-content-H')
					   bottom: (e valueOfTokenNamed: #'padding-content-V')
					   right: (e valueOfTokenNamed: #'padding-content-H') ].
			   sr select: self haveExactHeight not style: [
				   sr
					   write: (self property: #height)
					   with: [ :e | e valueOfTokenNamed: #'control-height' ] ] ]).
			
		  (((#'labeled-icon' asStampSelector) withParent: #button atDepth: 1) style: [
			   :sr |
			   sr
				   write: (self property: #layout)
				   with: BlLinearLayout horizontal.

			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal fitContent.
				   c vertical fitContent.
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> commonButtonRulesNew [

	<script:
	'(ToStyleSheetCSSLikePrinter styleRules: (self new commonButtonRulesOld)) asCSSLikeString inspect'>
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		  (#button asStampSelector style: [ :sr |
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #mouseCursor)
				   with: [ :e |
					   e isEnabled
						   ifTrue: [ Cursor webLink ]
						   ifFalse: [  ] ].
			   sr
				   when: ToLeavedLookEvent
				   write: (self property: #mouseCursor)
				   with: nil.

			   sr select: #vertical asStampSelector not style: [
				   sr write: (self property: #padding) with: [ :e |
					   BlInsets
						   top: (e valueOfTokenNamed: #'padding-XS') / 2
						   left: (e valueOfTokenNamed: #'padding-content-H') / 2
						   bottom: (e valueOfTokenNamed: #'padding-XS') / 2
						   right: (e valueOfTokenNamed: #'padding-content-H') / 2 ].

				   sr select: self haveExactHeight not style: [
					   sr
						   write: (self property: #height)
						   with: [ :e | e valueOfTokenNamed: #'control-height' ] ].

				   sr select: #'large-sizing' style: [
					   sr
						   write: (self property: #height)
						   with: [ :e | e valueOfTokenNamed: #'control-height-LG' ] ].

				   sr select: #'small-sizing' style: [
					   sr
						   write: (self property: #height)
						   with: [ :e | e valueOfTokenNamed: #'control-height-SM' ] ] ].

			   " non circular button corner radius"
			   sr select: #circle asStampSelector not style: [
				   sr write: (self property: #geometry) with: [ :e |
					   BlRoundedRectangleGeometry cornerRadius:
						   (e valueOfTokenNamed: 'border-radius') ].

				   sr select: #round asStampSelector style: [
					   sr
						   write: (self property: #geometry)
						   with: [ :e |
						   BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] ] ] ]).

		  ((#'labeled-icon' asStampSelector withParent: #button atDepth: 1)
			   style: [ :sr |
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
				   sr
					   select:
					   (sr withParent: #flexible asStampSelector atDepth: 1) not
					   style: [
						   sr
							   write: (self property: #'layout-constraints')
							   with: [ :e |
								   [ :c |
								   c frame vertical alignCenter.
								   c frame horizontal alignCenter.
								   c linear vertical alignCenter.
								   c linear horizontal alignCenter ] ] ].

				   " with justification: innerElement is matchParent if it has a parent with #justified "
				   sr select: (sr withParent: #flexible atDepth: 1) style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c horizontal matchParent.
						   c vertical matchParent ] ] ].

				   sr select: (sr withParent: #'icon-first' atDepth: 1) style: [
					   sr
						   write: (self property: #'layout-direction')
						   with: [ :e | BlLayoutDirection leftToRight ] ].

				   sr select: (sr withParent: #'label-first' atDepth: 1) style: [
					   sr
						   write: (self property: #'layout-direction')
						   with: [ :e | BlLayoutDirection rightToLeft ] ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> commonButtonRulesOld [

	<script:
	'(ToStyleSheetCSSLikePrinter styleRules: (self new commonButtonRulesOld)) asCSSLikeString inspect'>
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		  (#button asStampSelector style: [ :sr |
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #mouseCursor)
				   with: [ :e |
					   e isEnabled
						   ifTrue: [ Cursor webLink ]
						   ifFalse: [  ] ].
			   sr
				   when: ToLeavedLookEvent
				   write: (self property: #mouseCursor)
				   with: nil.

			   sr select: #vertical asStampSelector not style: [
				   sr write: (self property: #padding) with: [ :e |
					   BlInsets
						   top: (e valueOfTokenNamed: #'padding-XS') / 2
						   left: (e valueOfTokenNamed: #'padding-content-H') / 2
						   bottom: (e valueOfTokenNamed: #'padding-XS') / 2
						   right: (e valueOfTokenNamed: #'padding-content-H') / 2 ].

				   sr select: self haveExactHeight not style: [
					   sr
						   write: (self property: #height)
						   with: [ :e | e valueOfTokenNamed: #'control-height' ] ].

				   sr select: #'large-sizing' style: [
					   sr
						   write: (self property: #height)
						   with: [ :e | e valueOfTokenNamed: #'control-height-LG' ] ].

				   sr select: #'small-sizing' style: [
					   sr
						   write: (self property: #height)
						   with: [ :e | e valueOfTokenNamed: #'control-height-SM' ] ] ].

			   " non circular button corner radius"
			   sr select: #circle asStampSelector not style: [
				   sr write: (self property: #geometry) with: [ :e |
					   BlRoundedRectangleGeometry cornerRadius:
						   (e valueOfTokenNamed: 'border-radius') ].

				   sr select: #round asStampSelector style: [
					   sr
						   write: (self property: #geometry)
						   with: [ :e |
						   BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] ] ] ]).

		  ((#'labeled-icon' asStampSelector withParent: #button atDepth: 1)
			   style: [ :sr |
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
				   sr
					   select:
					   (sr withParent: #flexible asStampSelector atDepth: 1) not
					   style: [
						   sr
							   write: (self property: #'layout-constraints')
							   with: [ :e |
								   [ :c |
								   c frame vertical alignCenter.
								   c frame horizontal alignCenter.
								   c linear vertical alignCenter.
								   c linear horizontal alignCenter ] ] ].

				   " with justification: innerElement is matchParent if it has a parent with #justified "
				   sr select: (sr withParent: #flexible atDepth: 1) style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c horizontal matchParent.
						   c vertical matchParent ] ] ].

				   sr select: (sr withParent: #'icon-first') style: [
					   sr
						   write: (self property: #'layout-direction')
						   with: [ :e | BlLayoutDirection leftToRight ] ].

				   sr select: (sr withParent: #'label-first') style: [
					   sr
						   write: (self property: #'layout-direction')
						   with: [ :e | BlLayoutDirection rightToLeft ] ] ]).

		  ((((#filler asStampSelector withParent: #( #button ) atDepth: 2)
			     sibling: #'button-label') sibling: #'button-icon') style: [
			   :sr |
			   sr
				   write: (self property: #layout)
				   with: [ :e | BlFrameLayout new ].

			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c horizontal exact:
					   (e valueOfTokenNamed: #'padding-content-H') / 3.
				   c vertical exact: (e valueOfTokenNamed: #'padding-content-H') / 3 ] ].


			   sr select: (sr withParent: #justified atDepth: 2) style: [
				   sr write: (self property: #'layout-constraints') with: [ :e |
					   [ :c |
					   c horizontal matchParent.
					   c vertical matchParent.
					   c minWidth: (e valueOfTokenNamed: #'padding-content-H') / 3.
					   c minHeight: (e valueOfTokenNamed: #'padding-content-H') / 3 ] ] ].

			   sr
				   select: (sr
						    withParent: #'interspace-1' asStampSelector - #vertical
						    atDepth: 2)
				   style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c horizontal exact:
							   (e valueOfTokenNamed: #'interspace-1') value.
						   c vertical matchParent ] ] ].

			   sr
				   select: (sr
						    withParent: #'interspace-1' asStampSelector + #vertical
						    atDepth: 2)
				   style: [
					   sr write: (self property: #'layout-constraints') with: [ :e |
						   [ :c |
						   c vertical exact: (e valueOfTokenNamed: #'interspace-1') value.
						   c horizontal matchParent ] ] ] ]).

		  ((self any - #filler withParent: #( #button ) atDepth: 2) style: [
			   :sr |
			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> defaultButtonRules [
	<script:'(ToStyleSheetCSSLikePrinter styleRules: (self new defaultButtonRules)) asCSSLikeString inspect'>
	
	| borderColorAnim borderEffectAnim |
		self deprecated: 'Not used anymore. see #initializeStyleRules'.

	borderColorAnim := ToPropertyBorderColorTransitionAnimation new duration: 500 milliSeconds.
	borderEffectAnim := ToPropertyBorderEffectTransitionAnimation new duration: 350 milliSeconds.

	^ {
		"Button background and border"
		self buttonSelector style:[ :sr |
			  
				"Background"
				sr
				   when: ToInstallLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container' ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
				
				"Border"
				sr select: #primary asStampSelector not style: [ 
				   
					sr when: ToInstallLookEvent
				 		write: (self property: #border)
						with: [ :e | BlBorder paint: (e valueOfTokenNamed: #'color-border') width: (e valueOfTokenNamed: #'line-width') ].
					sr
				   		when: ToLeavedLookEvent
						write: (self property: #border)
				 	  	with: [ :e | BlBorder paint: (e valueOfTokenNamed: #'color-border') width: (e valueOfTokenNamed: #'line-width') ]
						animation: borderColorAnim.
					sr
				  		when: ToDisabledLookEvent
				   		write: (self property: #border)
				   		with: [ :e | BlBorder paint: (e valueOfTokenNamed: #'color-border-disabled') width: (e valueOfTokenNamed: #'line-width') ].
					sr
				   		when: ToHoveredLookEvent
				   		write: (self property: #border)
				   		with: [ :e | BlBorder paint: (e valueOfTokenNamed: #'color-primary-hover') width: (e valueOfTokenNamed: #'line-width') ]
						animation: borderColorAnim.
					sr
				  		when: ToClickedLookEvent 
				   		write: (self property: #border)
				   		with: [ :e | BlBorder paint: (e valueOfTokenNamed: #'color-primary-hover') width: (e valueOfTokenNamed: #'line-width') ]
				   		animation: borderEffectAnim.
			   		sr
				  		when: ToPressedLookEvent
				   		write: (self property: #border)
				   		with: [ :e | BlBorder paint: (e valueOfTokenNamed: #'color-primary-pressed') width: (e valueOfTokenNamed: #'line-width') ]] .
					
				"Label"
				sr
				   when: ToInstallLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-text' ].
				sr
				   when: ToLeavedLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-text' ]. 
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary') ]. 
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary-pressed') ].
			
		  sr select: #( #dashed ) style: [ 
			   sr
				   when: ToInstallLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder dashArray: (e valueOfTokenNamed: #'dash-array') ] ] ]
	} 
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> defaultButtonRulesNew [
	" ToButton default rule including icon and label "

	" default button (class #button) "
		self deprecated: 'Not used anymore. see #initializeStyleRules'.


	^ 
		{ 
			  (#button asStampSelector style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ] ]).

		  (#button asStampSelector - #checkable style: [ :sr |
			   sr
				   when: ToEnabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-border');
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-border-disabled');
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-primary-hover');
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-primary-pressed');
						   yourself ] ]).

		  " default button form icon "
		  ((#image asStampSelector withParent: #button atDepth: 3) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e valueOfTokenNamed: #'color-text' ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary-pressed') ] ]).

		  " default button label "
		  ((#label asStampSelector withParent: #button atDepth: 3) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-text' ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary-pressed') ] ]).

		  " ToButton default danger"
		  (#( #button #danger ) asStampSelector - #checkable style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: (e valueOfTokenNamed: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: (e valueOfTokenNamed: #'color-border-disabled') ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: (e valueOfTokenNamed: #'color-error-hover') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: (e valueOfTokenNamed: #'color-error-pressed') ] ]).

		  " danger button form icon "
		  ((#image asStampSelector withParent: #( #button #danger ) atDepth: 3)
			   style: [ :sr |
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-error') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-image-disabled') ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-error-hover') ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-error-pressed') ] ]).

		  " danger button label "
		  ((#label asStampSelector withParent: #( #button #danger ) atDepth: 3)
			   style: [ :sr |
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e valueOfTokenNamed: #'color-error') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e valueOfTokenNamed: #'color-error-hover') ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e valueOfTokenNamed: #'color-error-pressed') ] ]).

		  " default button dashed "
		  (#( #dashed ) asStampSelector style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder dashArray: (e valueOfTokenNamed: #'dash-array') ] ]) } 
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> defaultButtonRulesOld [
	" ToButton default rule including icon and label "

	" default button (class #button) "
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ 
		{ 
			  (#button asStampSelector style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ] ]).

		  (#button asStampSelector - #checkable style: [ :sr |
			   sr
				   when: ToEnabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-border');
						   yourself ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-border-disabled');
						   yourself ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-primary-hover');
						   yourself ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   paint: (e valueOfTokenNamed: #'color-primary-pressed');
						   yourself ] ]).

		  " default button form icon "
		  ((#image asStampSelector parent: #button depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e valueOfTokenNamed: #'color-text' ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary-pressed') ] ]).

		  " default button label "
		  ((#label asStampSelector parent: #button depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-text' ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary-pressed') ] ]).

		  " ToButton default danger"
		  (#( #button #danger ) asStampSelector - #checkable style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: (e valueOfTokenNamed: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: (e valueOfTokenNamed: #'color-border-disabled') ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: (e valueOfTokenNamed: #'color-error-hover') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: (e valueOfTokenNamed: #'color-error-pressed') ] ]).

		  " danger button form icon "
		  ((#image asStampSelector parent: #( #button #danger ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-error') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-image-disabled') ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-error-hover') ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-error-pressed') ] ]).

		  " danger button label "
		  ((#label asStampSelector parent: #( #button #danger ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e valueOfTokenNamed: #'color-error') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e valueOfTokenNamed: #'color-error-hover') ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e valueOfTokenNamed: #'color-error-pressed') ] ]).

		  " default button dashed "
		  (#( #dashed ) asStampSelector style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   supplement: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder dashArray: (e valueOfTokenNamed: #'dash-array') ] ]) } 
]

{ #category : #'accessing rules  - label' }
ToBeeStyleSheet >> labelRules [
	" label  rules"
	self deprecated: 'Not used anymore. see #initializeStyleRules'.
	^ { (ToLabel asTypeSelector style: [ :sr |
		   sr select: self any style: [
			   sr
				   write: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   weight: (e valueOfTokenNamed: #'font-weight-strong');
						   defaultFontName: (e valueOfTokenNamed: #'font-family-code');
						   defaultFontSize: (e valueOfTokenNamed: #'font-size');
						   lineSpacing: (e valueOfTokenNamed: #'line-height');
						   yourself ] ].

		   sr
			   when: ToDisabledLookEvent
			   write: (self property: #'text-attributes-with-builder')
			   with: [ :e |
				   e textAttributesBuilder foreground:
					   (e valueOfTokenNamed: #'color-text-disabled') ].

		   sr select: #H1 style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e valueOfTokenNamed: #'font-size-H1');
						   lineSpacing: (e valueOfTokenNamed: #'line-height-H1');
						   yourself ] ].

		   sr select: #H2 style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e valueOfTokenNamed: #'font-size-H2');
						   lineSpacing: (e valueOfTokenNamed: #'line-height-H2');
						   yourself ] ].

		   sr select: #H3 style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e valueOfTokenNamed: #'font-size-H3');
						   lineSpacing: (e valueOfTokenNamed: #'line-height-H3');
						   yourself ] ].

		   sr select: #H4 style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e valueOfTokenNamed: #'font-size-H4');
						   lineSpacing: (e valueOfTokenNamed: #'line-height-H4');
						   yourself ] ].

		   sr select: #H5 style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   defaultFontSize: (e valueOfTokenNamed: #'font-size-H5');
						   lineSpacing: (e valueOfTokenNamed: #'line-height-H5');
						   yourself ] ].

		   sr select: #default style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e | 
					   e textAttributesBuilder
						   foreground: (e valueOfTokenNamed: #'color-text');
						   yourself ] ].

		   sr select: #danger style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e valueOfTokenNamed: #'color-error');
						   yourself ] ].

		   sr select: #link style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e valueOfTokenNamed: #'color-link');
						   yourself ] ].

		   sr select: #primary style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e valueOfTokenNamed: #'color-text-light-solid');
						   yourself ] ].

		   sr select: #secondary style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e valueOfTokenNamed: #'color-text-secondary');
						   yourself ] ].

		   sr select: #success style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e valueOfTokenNamed: #'color-success');
						   yourself ] ].

		   sr select: #warning style: [
			   sr
				   supplement: (self property: #'text-attributes-with-builder')
				   with: [ :e |
					   e textAttributesBuilder
						   foreground: (e valueOfTokenNamed: #'color-warning');
						   yourself ] ] ]) }
]

{ #category : #'accessing rules - labeled icon' }
ToBeeStyleSheet >> labeledIconRules [

	<script:
	'(ToStyleSheetCSSLikePrinter styleRules: (self new labeledIconRules)) asCSSLikeString inspect'>
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ { ((self any withParent: ToLabeledIcon asTypeSelector) style: [
		   :sr | " any child of a ToLabeledIcon is centered vertically and horizontally ( icon, label and filler) "
		   sr write: (self property: #'layout-constraints') with: [ :e |
			   [ :c |
			   c linear vertical alignCenter.
			   c linear horizontal alignCenter ] ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> linkButtonRules [
	" ToButton link "
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		  (#( #button #link ) asStampSelector style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder width: 0 ] ]).

		  " ToButton link danger "
		  (#( #button #link #danger ) asStampSelector style: [ :sr |
			   sr
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder width: 0 ] ]).

		  " button link form icon "
		  ((#image asStampSelector parent: #( #button #link ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-link') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e valueOfTokenNamed: #'color-link-hover'  ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-primary-pressed') ] ]).

		  " button link label "
		  ((#label asStampSelector parent: #( #button #link ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e valueOfTokenNamed: #'color-link') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e valueOfTokenNamed: #'color-link-hover') ].
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | (e valueOfTokenNamed: #'color-primary-pressed') ] ]).

		  " button link danger form icon "
		  ((#image asStampSelector
			    parent: #( #button #link #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-error-hover') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-error-pressed') ] ]).

		  " button link danger label "
		  ((#label asStampSelector
			    parent: #( #button #link #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-error-hover') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-error-pressed') ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> primaryButtonRules [
	<script:'(ToStyleSheetCSSLikePrinter styleRules: (self new primaryButtonRules)) asCSSLikeString inspect'>
	
	| backgroundColorAnim |
	" the animation must be shared by all writers which are using it to stop it correctly "
	backgroundColorAnim := ToPropertyColorTransitionAnimation new duration: 150 milliSeconds.
		self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		"Button background and border"
		((self buttonSelector + #primary) style: [ :sr |
			   
				"Background"
				sr
				   when: ToInstallLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary') ].
				 sr
				   when: ToLeavedLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary') ]
				   animation: backgroundColorAnim.
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary-hover') ]
				   animation: backgroundColorAnim.
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary-pressed') ]
					animation: backgroundColorAnim.

				"Border"
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: (Color transparent); width: (e valueOfTokenNamed: #'line-width') ].
				sr
				   when: ToLeavedLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: (Color transparent); width: (e valueOfTokenNamed: #'line-width') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: (e valueOfTokenNamed: #'color-border-disabled'); width: (e valueOfTokenNamed: #'line-width') ].
				self flag:'pla: make a border-color shortcut'.
				
				"Label"
				sr
				   when: ToInstallLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-text-light-solid') ].
				sr
				   when: ToLeavedLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-text-light-solid') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-text-light-solid') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'button-label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-text-light-solid') ].
			]
		).
	}
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> primaryButtonRulesOld [
	<script:'(ToStyleSheetCSSLikePrinter styleRules: (self new primaryButtonRulesOld)) asCSSLikeString inspect'>
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		  (#button asStampSelector + #primary style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #background)
				   with: [ :e | (e valueOfTokenNamed: #'color-primary') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary-hover') ]
				   animation: ToPropertyColorTransitionAnimation new.
			   sr
				   when: ToLeavedLookEvent
				   write: (self property: #'background-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-primary') ]
				   animation: ToPropertyColorTransitionAnimation new.
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | (e valueOfTokenNamed: #'color-primary-pressed') ].

			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e | e borderBuilder paint: Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
				   e borderBuilder paint: (e valueOfTokenNamed: #'color-border-disabled') ].


			   sr select: #danger style: [
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #background)
					   with: [ :e | (e valueOfTokenNamed: #'color-error') ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #background)
					   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
				   sr
					   when: ToHoveredLookEvent
					   write: (self property: #'background-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-error-hover') ]
					   animation: ToPropertyColorTransitionAnimation new.
				   sr
					   when: ToLeavedLookEvent
					   write: (self property: #'background-color')
					   with: [ :e | (e valueOfTokenNamed: #'color-error') ]
					   animation: ToPropertyColorTransitionAnimation new.
				   sr
					   when: ToPressedLookEvent
					   write: (self property: #background)
					   with: [ :e | e valueOfTokenNamed: #'color-error-pressed' ].

				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e | e borderBuilder paint: Color transparent ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'border-with-builder')
					   with: [ :e |
					   e borderBuilder paint: (e valueOfTokenNamed: #'color-border-disabled') ] ] ]).

		  " primary button form icon "

		  ((#image asStampSelector
			    parent: #button asStampSelector + #primary
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-image-light-solid') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-image-disabled') ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-image-light-solid') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-image-light-solid') ] ]).

		  " primary button label "

		  ((#label asStampSelector
			    parent: #button asStampSelector + #primary
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-text-light-solid') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-text-light-solid') ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-text-light-solid') ] ]) }
]

{ #category : #'accessing rules  - pane' }
ToBeeStyleSheet >> rootPaneRules [
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ { ((self id: #'space-root') style: [ :sr |
		   sr
			   write: (self property: #background)
			   with: [ :e | e valueOfTokenNamed: #'background-color' ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> textButtonRules [
	" ToButton text "
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		  (#( #button #text ) asStampSelector style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-bg-text-hover' ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-bg-text-active' ].

			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ] ]).

		  " ToButton text danger "

		  (#( #button #text #danger ) asStampSelector style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #background)
				   with: [ :e | Color transparent ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
			   sr
				   when: ToHoveredLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-error-bg' ].
			   sr
				   when: ToPressedLookEvent
				   write: (self property: #background)
				   with: [ :e | e valueOfTokenNamed: #'color-error-bg' ].

			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ] ]).

		  " button text form icon "

		  ((#image asStampSelector parent: #( #button #text ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e valueOfTokenNamed: #'color-text' ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'image-inner-form-color')
					   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ] ]).

		  " button test label "

		  ((#label asStampSelector parent: #( #button #text ) depth: 2)
			   style: [ :sr |
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e valueOfTokenNamed: #'color-text' ].
				   sr
					   when: ToDisabledLookEvent
					   write: (self property: #'label-text-foreground')
					   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ] ]).

		  " button text danger form icon "

		  ((#image asStampSelector
			    parent: #( #button #text #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | (e valueOfTokenNamed: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'image-inner-form-color')
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ] ]).

		  " button test danger label "

		  ((#label asStampSelector
			    parent: #( #button #text #danger )
			    depth: 2) style: [ :sr |
			   sr
				   when: ToInstallLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | (e valueOfTokenNamed: #'color-error') ].
			   sr
				   when: ToDisabledLookEvent
				   write: (self property: #'label-text-foreground')
				   with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ] ]) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> toggleButtonRules [
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ { ( #(#button #'toggle-button') asStampSelector style: [ :sr |
		   sr
			   write: (self property: #background)
			   with: [ :e | Color transparent ].
			sr
				   when: ToInstallLookEvent
				   write: (self property: #'border-with-builder')
				   with: [ :e |
					   e borderBuilder
						   width: 0;
						   yourself ].
			
		
		
		
		
				] ) }
]

{ #category : #'accessing rules  -button' }
ToBeeStyleSheet >> verticalButtonRules [
	"  
	'button:hover' rule: [ :e | e mouseCursor: Cursor hand. e background: Color gray. e font-size: 18 ].
	'button:leave' rule: [ :e | e mouseCursor: nil ].

	'button' rule: [ :e | e background: Color white ].
	'button:hover' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].
	'button:hover, button:leave' rule: [ :e | e background: Color gray ].
	'button:leave' rule: [ :e | e background: Color white ].
	"
	self deprecated: 'Not used anymore. see #initializeStyleRules'.

	^ {
		  (#( #button #vertical ) asStampSelector style: [ :sr |
			   sr write: (self property: #padding) with: [ :e |
				   BlInsets
					   top: (e valueOfTokenNamed: #'padding-content-H') / 2
					   left: (e valueOfTokenNamed: #'padding-XS') / 2
					   bottom: (e valueOfTokenNamed: #'padding-content-H') / 2
					   right: (e valueOfTokenNamed: #'padding-XS') / 2 ].

			   sr write: (self property: #'layout-constraints') with: [ :e |
				   [ :c |
				   c linear vertical alignCenter.
				   c linear horizontal alignCenter ] ] ]).

		  ((#'inner-element' asStampSelector parent: #( #button #vertical ))
			   style: [ :sr |
				   sr
					   when: ToInstallLookEvent
					   write: (self property: #layout)
					   with: BlLinearLayout vertical ]) }
]
