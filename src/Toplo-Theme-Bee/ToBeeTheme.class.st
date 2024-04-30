"
This theme is inpired by Ant (https://ant.design/docs/spec/introduce).
This theme exists in two variants : light (by default) and dark.
This theme can be derive using ""primaryColor"" properties to create color variants.

colorBgContainer	Container background color, e.g: default button, input box, etc. Be sure not to confuse this with `colorBgElevated`.	string	#ffffff
colorBgContainerDisabled	Control the background color of container in disabled state.	string	rgba(0, 0, 0, 0.04)
colorBgTextActive	Control the background color of text in active state.	string	rgba(0, 0, 0, 0.15)
colorBgTextHover	Control the background color of text in hover state.	string	rgba(0, 0, 0, 0.06)
colorBorder	Default border color, used to separate different elements, such as: form separator, card separator, etc.	string	#d9d9d9
colorError	Used to represent the visual elements of the operation failure, such as the error Button, error Result component, etc.	string	#ff4d4f
colorErrorActive	The active state of the error color.	string	#d9363e
colorErrorBg	The background color of the error state.	string	#fff2f0
colorErrorBorderHover	The hover state border color of the error state.	string	#ffa39e
colorErrorHover	The hover state of the error color.	string	#ff7875
colorErrorOutline	Control the outline color of input component in error state.	string	rgba(255, 38, 5, 0.06)
colorLink	Control the color of hyperlink.	string	#1677ff
colorLinkActive	Control the color of hyperlink when clicked.	string	#0958d9
colorLinkHover	Control the color of hyperlink when hovering.	string	#69b1ff
colorPrimary	Brand color is one of the most direct visual elements to reflect the characteristics and communication of the product. After you have selected the brand color, we will automatically generate a complete color palette and assign it effective design semantics.	string	#1677ff
colorPrimaryActive	Dark active state under the main color gradient.	string	#0958d9
colorPrimaryBorder	The stroke color under the main color gradient, used on the stroke of components such as Slider.	string	#91caff
colorPrimaryHover	Hover state under the main color gradient.	string	#4096ff
colorText	Default text color which comply with W3C standards, and this color is also the darkest neutral color.	string	rgba(0, 0, 0, 0.88)
colorTextDisabled	Control the color of text in disabled state.	string	rgba(0, 0, 0, 0.25)
colorTextLightSolid	Control the highlight color of text with background color, such as the text in Primary Button components.	string	#fff
borderRadius	Border radius of base components	number	6
borderRadiusLG	LG size border radius, used in some large border radius components, such as Card, Modal and other components.	number	8
borderRadiusSM	SM size border radius, used in small size components, such as Button, Input, Select and other input components in small size	number	4
controlHeight	The height of the basic controls such as buttons and input boxes in Ant Design	number	32
controlHeightLG	LG component height	number	40
controlHeightSM	SM component height	number	24
controlOutline	Control the outline color of input component.	string	rgba(5, 145, 255, 0.1)
controlOutlineWidth	Control the outline width of input component.	number	2
controlTmpOutline	Default style outline color.	string	rgba(0, 0, 0, 0.02)
fontSize	The most widely used font size in the design system, from which the text gradient will be derived.	number	14
fontSizeLG	Large font size	number	16
lineHeight	Line height of text.	number	1.5714285714285714
lineType	Border style of base components	string	solid
lineWidth	Border width of base components	number	1
lineWidthFocus	Control the width of the line when the component is in focus state.	number	4
marginXS	Control the margin of an element, with a small size.	number	8
motionDurationMid	Motion speed, medium speed. Used for medium element animation interaction.	string	0.2s
motionDurationSlow	Motion speed, slow speed. Used for large element animation interaction.	string	0.3s
motionEaseInOut	Preset motion curve.	string	cubic-bezier(0.645, 0.045, 0.355, 1)
opacityLoading	Control the opacity of the loading state.	number	0.65
paddingContentHorizontal	Control the horizontal padding of content element.	number	16
paddingXS	Control the extra small padding of the element.	number	8

"
Class {
	#name : #ToBeeTheme,
	#superclass : #ToStyleSheetTheme,
	#category : #'Toplo-Theme-Bee'
}

{ #category : #testing }
ToBeeTheme class >> canBeDefault [

	^ true
]

{ #category : #accessing }
ToBeeTheme class >> label [ 

	^ 'Bee'
]

{ #category : #'syntactic sugar' }
ToBeeTheme >> buttonSelector [

	^ ToButton asTypeSelector
]

{ #category : #'rules declaring - button - private' }
ToBeeTheme >> declareBackgroundStyleWithTokenDefault: aDefaultColorToken tokenHover: aHoverColorToken tokenPressed: aPressedColorToken [

	| backgroundColorAnim |
	" the animation must be shared by all writers which are using it to stop it correctly "
	backgroundColorAnim := ToPropertyColorTransitionAnimation new
		                       duration: 150 milliSeconds.

	self
		when: ToInstallLookEvent
		write: (self property: #'background-color')
		with: [ :e | e valueOfTokenNamed: aDefaultColorToken ].
	self
		when: ToLeavedLookEvent
		write: (self property: #'background-color')
		with: [ :e | e valueOfTokenNamed: aDefaultColorToken ]
		animation: backgroundColorAnim.
	self
		when: ToHoveredLookEvent
		write: (self property: #'background-color')
		with: [ :e | e valueOfTokenNamed: aHoverColorToken ]
		animation: backgroundColorAnim.
	self
		when: ToPressedLookEvent
		write: (self property: #'background-color')
		with: [ :e | e valueOfTokenNamed: aPressedColorToken ]
		animation: backgroundColorAnim
]

{ #category : #'rules declaring - button - private' }
ToBeeTheme >> declareBorderStyleWithTokenDefault: aDefaultColorToken tokenHover: aHoverColorToken tokenPressed: aPressedColorToken [

	| borderColorAnim borderEffectAnim |
	borderColorAnim := ToPropertyBorderColorTransitionAnimation new
		                   duration: 500 milliSeconds.
	borderEffectAnim := ToPropertyBorderEffectTransitionAnimation new
		                    duration: 350 milliSeconds.
	self
		when: ToInstallLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aDefaultColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				build ].
	self
		when: ToLeavedLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aDefaultColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				build ]
		animation: borderColorAnim.
	self
		when: ToHoveredLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aHoverColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				build ]
		animation: borderColorAnim.
	self
		when: ToClickedLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aPressedColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				build ]
		animation: borderEffectAnim.
	self
		when: ToPressedLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aPressedColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				build ]
]

{ #category : #'rules declaring - button' }
ToBeeTheme >> declareButtonRules [

	self declareLabeledIconInButtonRules.

	self select: self buttonSelector style: [
		self declareCommonButtonRules.
		self declareDefaultButtonRules.
		self declareDashedButtonRules.
		self declareTextButtonRules.
		self declareLinkButtonRules.
		self declarePrimaryButtonRules ]
]

{ #category : #'rules declaring - button' }
ToBeeTheme >> declareCommonButtonRules [

		self
			when: ToHoveredLookEvent
			write: (self property: #mouseCursor)
			with: [ :e |
				e isEnabled
					ifTrue: [ Cursor webLink ]
					ifFalse: [  ] ].
		self
			when: ToLeavedLookEvent
			write: (self property: #mouseCursor)
			with: nil.

		self select: #vertical asStampSelector not style: [
			self write: (self property: #padding) with: [ :e |
				BlInsets
					top: (e valueOfTokenNamed: #'padding-XS') / 2
					left: (e valueOfTokenNamed: #'padding-content-H') / 2
					bottom: (e valueOfTokenNamed: #'padding-XS') / 2
					right: (e valueOfTokenNamed: #'padding-content-H') / 2 ].

			self select: self haveExactHeight not style: [
				self
					write: (self property: #height)
					with: [ :e | e valueOfTokenNamed: #'control-height' ] ].

			self select: #'large-sizing' asStampSelector style: [
				self
					write: (self property: #height)
					with: [ :e | e valueOfTokenNamed: #'control-height-LG' ] ].

			self select: #'small-sizing' asStampSelector style: [
				self
					write: (self property: #height)
					with: [ :e | e valueOfTokenNamed: #'control-height-SM' ] ] ].

		" non circular button corner radius"
		self select: #circle asStampSelector not style: [
			self write: (self property: #geometry) with: [ :e |
				BlRoundedRectangleGeometry cornerRadius:
					(e valueOfTokenNamed: 'border-radius') ].

			self select: #round asStampSelector style: [
				self
					write: (self property: #geometry)
					with: [ :e |
					BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] ] ]
]

{ #category : #'rules declaring - button - private' }
ToBeeTheme >> declareDashedBorderStyleWithTokenDefault: aDefaultColorToken tokenHover: aHoverColorToken tokenPressed: aPressedColorToken [

	| borderColorAnim borderEffectAnim |
	borderColorAnim := ToPropertyBorderColorTransitionAnimation new
		                   duration: 500 milliSeconds.
	borderEffectAnim := ToPropertyBorderEffectTransitionAnimation new
		                    duration: 350 milliSeconds.
	self
		when: ToInstallLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aDefaultColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				dashArray: (e valueOfTokenNamed: #'dash-array');
				build ].
	self
		when: ToLeavedLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aDefaultColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				dashArray: (e valueOfTokenNamed: #'dash-array');
				build ]
		animation: borderColorAnim.
	self
		when: ToHoveredLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aHoverColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				dashArray: (e valueOfTokenNamed: #'dash-array');
				build ]
		animation: borderColorAnim.
	self
		when: ToClickedLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aPressedColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				dashArray: (e valueOfTokenNamed: #'dash-array');
				build ]
		animation: borderEffectAnim.
	self
		when: ToPressedLookEvent
		write: (self property: #border)
		with: [ :e |
			BlBorderBuilder new
				paint: (e valueOfTokenNamed: aPressedColorToken);
				width: (e valueOfTokenNamed: #'line-width');
				dashArray: (e valueOfTokenNamed: #'dash-array');
				build ]
]

{ #category : #'rules declaring - button' }
ToBeeTheme >> declareDashedButtonRules [

	self select: #( #dashed ) asStampSelector style: [
		self
			when: ToDisabledLookEvent
			write: (self property: #border)
			with: [ :e |
				BlBorderBuilder new
					paint: (e valueOfTokenNamed: #'color-border-disabled');
					width: (e valueOfTokenNamed: #'line-width');
					dashArray: (e valueOfTokenNamed: #'dash-array');
					build ].
		self select: #danger asStampSelector not style: [
			self
				declareDashedBorderStyleWithTokenDefault: #'color-border'
				tokenHover: #'color-primary-hover'
				tokenPressed: #'color-primary-pressed' ].
		self select: #danger asStampSelector style: [
			self
				declareDashedBorderStyleWithTokenDefault: #'color-error'
				tokenHover: #'color-error-hover'
				tokenPressed: #'color-error-pressed' ] ]
]

{ #category : #'rules declaring - button' }
ToBeeTheme >> declareDefaultButtonRules [


	"Button background and border"
	"Background"
	self
		when: ToDisabledLookEvent
		write: (self property: #'background-color')
		with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].
	self
		when: ToInstallLookEvent
		write: (self property: #'background-color')
		with: [ :e | e valueOfTokenNamed: #'color-bg-container' ].

	"Border"
	self
		select: (#dashed asStampSelector
			 || #text asStampSelector || #link asStampSelector) not
		style: [
			self
				when: ToDisabledLookEvent
				write: (self property: #border)
				with: [ :e |
					BlBorder
						paint: (e valueOfTokenNamed: #'color-border-disabled')
						width: (e valueOfTokenNamed: #'line-width') ].
			self select: #danger asStampSelector not style: [
				self
					declareBorderStyleWithTokenDefault: 'color-border'
					tokenHover: 'color-primary-hover'
					tokenPressed: 'color-primary-pressed' ].
			self select: #danger asStampSelector style: [
				self
					declareBorderStyleWithTokenDefault: #'color-error'
					tokenHover: #'color-error-hover'
					tokenPressed: #'color-error-pressed' ] ].

	"Label"
	self select: #link asStampSelector not style: [
		self
			when: ToDisabledLookEvent
			write: (self property: #'button-label-text-foreground')
			with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
		self select: #danger asStampSelector not style: [
			self
				declareLabelStyleWithTokenDefault: #'color-text'
				tokenHover: #'color-primary'
				tokenPressed: #'color-primary-pressed' ].
		self select: #danger asStampSelector style: [
			self
				declareLabelStyleWithTokenDefault: #'color-error'
				tokenHover: #'color-error-hover'
				tokenPressed: #'color-error-pressed' ] ]
]

{ #category : #'rules declaring - button' }
ToBeeTheme >> declareIconInLabeledIconRules [

	self
		select: (ToImage asTypeSelector
				 withParent: #'labeled-icon' asStampSelector
				 atDepth: 2)
		style: [
			self write: (self property: #'layout-constraints') with: [ :e |
				[ :c |
				c linear vertical alignCenter.
				c linear horizontal alignCenter ] ] ]
]

{ #category : #'rules declaring - label' }
ToBeeTheme >> declareLabelRules [
	" label  rules"

	self select: ToLabel asTypeSelector style: [
		self
			write: (self property: #'text-attributes-with-builder')
			with: [ :e |
				e textAttributesBuilder
					weight: (e valueOfTokenNamed: #'font-weight-strong');
					defaultFontName: (e valueOfTokenNamed: #'font-family-code');
					defaultFontSize: (e valueOfTokenNamed: #'font-size');
					lineSpacing: (e valueOfTokenNamed: #'line-height');
					yourself ].

		self
			when: ToDisabledLookEvent
			write: (self property: #'text-attributes-with-builder')
			with: [ :e |
				e textAttributesBuilder foreground:
					(e valueOfTokenNamed: #'color-text-disabled') ].

		self select: #H1 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e valueOfTokenNamed: #'font-size-H1');
						lineSpacing: (e valueOfTokenNamed: #'line-height-H1');
						yourself ] ].

		self select: #H2 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e valueOfTokenNamed: #'font-size-H2');
						lineSpacing: (e valueOfTokenNamed: #'line-height-H2');
						yourself ] ].

		self select: #H3 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e valueOfTokenNamed: #'font-size-H3');
						lineSpacing: (e valueOfTokenNamed: #'line-height-H3');
						yourself ] ].

		self select: #H4 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e valueOfTokenNamed: #'font-size-H4');
						lineSpacing: (e valueOfTokenNamed: #'line-height-H4');
						yourself ] ].

		self select: #H5 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e valueOfTokenNamed: #'font-size-H5');
						lineSpacing: (e valueOfTokenNamed: #'line-height-H5');
						yourself ] ].

		self select: #default asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e valueOfTokenNamed: #'color-text');
						yourself ] ].

		self select: #danger asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e valueOfTokenNamed: #'color-error');
						yourself ] ].

		self select: #link asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e valueOfTokenNamed: #'color-link');
						yourself ] ].

		self select: #primary asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e valueOfTokenNamed: #'color-text-light-solid');
						yourself ] ].

		self select: #secondary asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e valueOfTokenNamed: #'color-text-secondary');
						yourself ] ].

		self select: #success asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e valueOfTokenNamed: #'color-success');
						yourself ] ].

		self select: #warning asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e valueOfTokenNamed: #'color-warning');
						yourself ] ] ]
]

{ #category : #'rules declaring - button - private' }
ToBeeTheme >> declareLabelStyleWithTokenDefault: aDefaultColorToken tokenHover: aHoverColorToken tokenPressed: aTokenColorToken [

	self
		when: ToDisabledLookEvent
		write: (self property: #'button-label-text-foreground')
		with: [ :e | e valueOfTokenNamed: #'color-text-disabled' ].
	self
		when: ToInstallLookEvent
		write: (self property: #'button-label-text-foreground')
		with: [ :e | e valueOfTokenNamed: aDefaultColorToken ].
	self
		when: ToLeavedLookEvent
		write: (self property: #'button-label-text-foreground')
		with: [ :e | e valueOfTokenNamed: aDefaultColorToken ].
	self
		when: ToHoveredLookEvent
		write: (self property: #'button-label-text-foreground')
		with: [ :e | e valueOfTokenNamed: aHoverColorToken ].
	self
		when: ToPressedLookEvent
		write: (self property: #'button-label-text-foreground')
		with: [ :e | e valueOfTokenNamed: aTokenColorToken ]
]

{ #category : #'rules declaring - button' }
ToBeeTheme >> declareLabeledIconInButtonRules [

	self
		select: (#'labeled-icon' asStampSelector
				 withParent: #button asStampSelector
				 atDepth: 1)
		style: [
			self
				write: (self property: #layout)
				with: [ :e | BlLinearLayout horizontal].

			self write: (self property: #'layout-constraints') with: [ :e |
				[ :c |
				c horizontal fitContent.
				c vertical fitContent.
				c linear vertical alignCenter.
				c linear horizontal alignCenter ] ].

			" without justification "
			self
				select:
				(self withParent: #'start-flexible' asStampSelector atDepth: 1) not
				style: [
					self write: (self property: #'layout-constraints') with: [ :e |
						[ :c |
						c frame vertical alignCenter.
						c frame horizontal alignCenter.
						c linear vertical alignCenter.
						c linear horizontal alignCenter ] ] ].

			" with justification: innerElement is matchParent if it has a parent with #justified "
			self
				select: (self withParent: #'start-flexible' asStampSelector atDepth: 1)
				style: [
					self write: (self property: #'layout-constraints') with: [ :e |
						[ :c |
						c horizontal matchParent.
						c vertical matchParent ] ] ].

			self
				select:
				(self withParent: #'icon-first' asStampSelector atDepth: 1)
				style: [
					self
						write: (self property: #'layout-direction')
						with: [ :e | BlLayoutDirection leftToRight ] ].

			self
				select:
				(self withParent: #'label-first' asStampSelector atDepth: 1)
				style: [
					self
						write: (self property: #'layout-direction')
						with: [ :e | BlLayoutDirection rightToLeft ] ] ]
]

{ #category : #'rules declaring - button' }
ToBeeTheme >> declareLinkButtonRules [

	self select: #link asStampSelector style: [ "Border"
		self declareNoBorder.
		self
			when: ToDisabledLookEvent
			write: (self property: #'background-color')
			with: [ :e | Color transparent ].

		"Label"
		self select: #danger asStampSelector not style: [
			self
				declareLabelStyleWithTokenDefault: #'color-link'
				tokenHover: #'color-link-hover'
				tokenPressed: #'color-link-active' ].
		self select: #danger asStampSelector style: [
			self
				declareLabelStyleWithTokenDefault: #'color-error'
				tokenHover: #'color-error-hover'
				tokenPressed: #'color-error-pressed' ] ]
]

{ #category : #'rules declaring - button - private' }
ToBeeTheme >> declareNoBorder [

	self
		when: ToInstallLookEvent
		write: (self property: #'border')
		with: [ :e |
			BlBorder
				paint: Color transparent
				width: (e valueOfTokenNamed: #'line-width') ].
	self
		when: ToLeavedLookEvent
		write: (self property: #'border')
		with: [ :e |
			BlBorder
				paint: Color transparent
				width: (e valueOfTokenNamed: #'line-width') ].
	self
		when: ToDisabledLookEvent
		write: (self property: #'border')
		with: [ :e |
			BlBorder
				paint: Color transparent
				width: (e valueOfTokenNamed: #'line-width') ]
]

{ #category : #'rules declaring - button' }
ToBeeTheme >> declarePrimaryButtonRules [

	self
		select: #primary asStampSelector
		style: [ "Background and border"
			self
				when: ToDisabledLookEvent
				write: (self property: #'background-color')
				with: [ :e | e valueOfTokenNamed: #'color-bg-container-disabled' ].

			self select: #danger asStampSelector not style: [
				self
					declareBackgroundStyleWithTokenDefault: #'color-primary'
					tokenHover: #'color-primary-hover'
					tokenPressed: #'color-primary-pressed'.
				self
					declareBorderStyleWithTokenDefault: #'color-primary'
					tokenHover: #'color-primary-hover'
					tokenPressed: #'color-primary-pressed' ].
			self select: #danger asStampSelector style: [
				self
					declareBackgroundStyleWithTokenDefault: #'color-error'
					tokenHover:  #'color-error-hover'
					tokenPressed: #'color-error-pressed'.
				self
					declareBorderStyleWithTokenDefault:  #'color-error'
					tokenHover:  #'color-error-hover'
					tokenPressed: #'color-error-pressed' ].

			"Label"
			self
				declareLabelStyleWithTokenDefault: #'color-text-light-solid'
				tokenHover: #'color-text-light-solid'
				tokenPressed: #'color-text-light-solid' ]
]

{ #category : #'rules declaring - pane' }
ToBeeTheme >> declareRootPaneRules [

	self select: (self id: #'space-root') style: [
		self
			write: (self property: #background)
			with: [ :e | e valueOfTokenNamed: #'background-color' ] ]
]

{ #category : #'rules declaring - button' }
ToBeeTheme >> declareTextButtonRules [

	self select: #text asStampSelector style: [ "Border"
		self declareNoBorder.
		self
		when: ToDisabledLookEvent
		write: (self property: #'background-color')
		with: [ :e | Color transparent ].

		"Background"
		self select: #danger asStampSelector not style: [
			self
				declareBackgroundStyleWithTokenDefault: #'color-bg-container'
				tokenHover: #'color-border'
				tokenPressed: #'border-paint' ].
		self select: #danger asStampSelector style: [
			self
				declareBackgroundStyleWithTokenDefault: #'color-bg-container'
				tokenHover: #'color-error-bg'
				tokenPressed: #'color-error-bg' ].


		"Label"
		self select: #danger asStampSelector not style: [
			self
				declareLabelStyleWithTokenDefault: #'color-text'
				tokenHover: #'color-text'
				tokenPressed: #'color-text' ].
		self select: #danger asStampSelector style: [
			self
				declareLabelStyleWithTokenDefault: #'color-error'
				tokenHover: #'color-error-hover'
				tokenPressed: #'color-error-pressed' ] ]
]

{ #category : #'rules-declaring-text' }
ToBeeTheme >> declareTextPaneRules [

	self select: (ToAlbum asTypeSelector exact: false) style: [
		self select: #placeholder asStampSelector style: [
			self
				write: (self property: #'text-attributes-with-builder')
				with: [ :e | 
					e textAttributesBuilder
						weight: (e valueOfTokenNamed: #'font-weight-strong');
						defaultFontName: (e valueOfTokenNamed: #'font-family-code');
						defaultFontSize: 28;
						foreground: Color lightGray lighter;
						lineSpacing: (e valueOfTokenNamed: #'line-height');
						yourself ] ] ]
]

{ #category : #initialization }
ToBeeTheme >> defaultElementStampsFor: anElement [ 

	^ anElement defaultBeeStyleStamps
]

{ #category : #initialization }
ToBeeTheme >> initializeStyleRules [ 

	super initializeStyleRules.
	self declareRootPaneRules.
	self declareLabelRules.
	self declareIconInLabeledIconRules.
	self declareButtonRules.
	self declareTextPaneRules 
]

{ #category : #styling }
ToBeeTheme >> skinClassFor: anElement [

	^ ToBeeSkin
]
