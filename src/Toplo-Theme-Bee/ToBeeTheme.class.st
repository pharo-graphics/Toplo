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
	#name : 'ToBeeTheme',
	#superclass : 'ToStyleSheetTheme',
	#category : 'Toplo-Theme-Bee',
	#package : 'Toplo-Theme-Bee'
}

{ #category : 'testing' }
ToBeeTheme class >> canBeDefault [

	^ true
]

{ #category : 'accessing' }
ToBeeTheme class >> label [ 

	^ 'Bee'
]

{ #category : 'testing' }
ToBeeTheme class >> supportedVariantClasses [

	^ { ToThemeDarkVariant. ToThemeLightVariant }
]

{ #category : 'syntactic sugar' }
ToBeeTheme >> buttonSelector [

	^ ToButton asTypeSelector
]

{ #category : 'rules declaring - button' }
ToBeeTheme >> declareButtonRules [

	self declareLabeledIconInButtonRules.
	self declareCommonButtonRules.
	self declareDefaultButtonRules.
	self declarePrimaryButtonRules
]

{ #category : 'rules declaring - button' }
ToBeeTheme >> declareCommonButtonRules [

	self select: self buttonSelector style: [
		self
			when: ToHoveredLookEvent
			write: (self property: #mouseCursor)
			with: [ :e |
				e isEnabled
					ifTrue: [ BlCursor hand ]
					ifFalse: [  ] ].
		self
			when: ToLeavedLookEvent
			write: (self property: #mouseCursor)
			with: nil.

		self select: #vertical asStampSelector not style: [
			self write: (self property: #padding) with: [ :e |
				BlInsets
					top: (e tokenValueNamed: #'padding-XS') / 2
					left: (e tokenValueNamed: #'padding-content-H') / 2
					bottom: (e tokenValueNamed: #'padding-XS') / 2
					right: (e tokenValueNamed: #'padding-content-H') / 2 ].

			self select: self haveExactHeight not style: [
				self
					write: (self property: #height)
					with: [ :e | e tokenValueNamed: #'control-height' ] ].

			self select: #'large-sizing' asStampSelector style: [
				self
					write: (self property: #height)
					with: [ :e | e tokenValueNamed: #'control-height-LG' ] ].

			self select: #'small-sizing' asStampSelector style: [
				self
					write: (self property: #height)
					with: [ :e | e tokenValueNamed: #'control-height-SM' ] ] ].

		" non circular button corner radius"
		self select: #circle asStampSelector not style: [
			self write: (self property: #geometry) with: [ :e |
				BlRoundedRectangleGeometry cornerRadius:
					(e tokenValueNamed: 'border-radius') ].

			self select: #round asStampSelector style: [
				self
					write: (self property: #geometry)
					with: [ :e |
					BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] ] ] ]
]

{ #category : 'rules declaring - button' }
ToBeeTheme >> declareDefaultButtonRules [

	| borderColorAnim borderEffectAnim |
	borderColorAnim := ToPropertyBorderColorTransitionAnimation new
		                   duration: 500 milliSeconds.
	borderEffectAnim := ToPropertyBorderEffectTransitionAnimation new
		                    duration: 350 milliSeconds.

	"Button background and border"
	self select: self buttonSelector style: [ "Background"
		self
			when: ToInstallLookEvent
			write: (self property: #'background-color')
			with: [ :e | e tokenValueNamed: #'color-bg-container' ].
		self
			when: ToDisabledLookEvent
			write: (self property: #'background-color')
			with: [ :e | e tokenValueNamed: #'color-bg-container-disabled' ].

		"Border"
		self select: #primary asStampSelector not style: [
			self
				when: ToInstallLookEvent
				write: (self property: #border)
				with: [ :e |
					BlBorder
						paint: (e tokenValueNamed: #'color-border')
						width: (e tokenValueNamed: #'line-width') ].
			self
				when: ToLeavedLookEvent
				write: (self property: #border)
				with: [ :e |
					BlBorder
						paint: (e tokenValueNamed: #'color-border')
						width: (e tokenValueNamed: #'line-width') ]
				animation: borderColorAnim.
			self
				when: ToDisabledLookEvent
				write: (self property: #border)
				with: [ :e |
					BlBorder
						paint: (e tokenValueNamed: #'color-border-disabled')
						width: (e tokenValueNamed: #'line-width') ].
			self
				when: ToHoveredLookEvent
				write: (self property: #border)
				with: [ :e |
					BlBorder
						paint: (e tokenValueNamed: #'color-primary-hover')
						width: (e tokenValueNamed: #'line-width') ]
				animation: borderColorAnim.
			self
				when: ToClickedLookEvent
				write: (self property: #border)
				with: [ :e |
					BlBorder
						paint: (e tokenValueNamed: #'color-primary-hover')
						width: (e tokenValueNamed: #'line-width') ]
				animation: borderEffectAnim.
			self
				when: ToPressedLookEvent
				write: (self property: #border)
				with: [ :e |
					BlBorder
						paint: (e tokenValueNamed: #'color-primary-pressed')
						width: (e tokenValueNamed: #'line-width') ] ].

		"Label"
		self
			when: ToInstallLookEvent
			write: (self property: #'button-label-text-foreground')
			with: [ :e | e tokenValueNamed: #'color-text' ].
		self
			when: ToLeavedLookEvent
			write: (self property: #'button-label-text-foreground')
			with: [ :e | e tokenValueNamed: #'color-text' ].
		self
			when: ToDisabledLookEvent
			write: (self property: #'button-label-text-foreground')
			with: [ :e | e tokenValueNamed: #'color-text-disabled' ].
		self
			when: ToHoveredLookEvent
			write: (self property: #'button-label-text-foreground')
			with: [ :e | e tokenValueNamed: #'color-primary' ].
		self
			when: ToPressedLookEvent
			write: (self property: #'button-label-text-foreground')
			with: [ :e | e tokenValueNamed: #'color-primary-pressed' ].

		self select: #( #dashed ) asStampSelector style: [
			self
				when: ToInstallLookEvent
				supplement: (self property: #'border-with-builder')
				with: [ :e |
				e borderBuilder dashArray: (e tokenValueNamed: #'dash-array') ] ] ]
]

{ #category : 'rules declaring - label' }
ToBeeTheme >> declareLabelRules [
	" label  rules"

	self select: ToLabel asTypeSelector style: [
		self
			write: (self property: #'text-attributes-with-builder')
			with: [ :e |
				e textAttributesBuilder
					weight: (e tokenValueNamed: #'font-weight-strong');
					defaultFontName: (e tokenValueNamed: #'font-family-code');
					defaultFontSize: (e tokenValueNamed: #'font-size');
					lineSpacing: (e tokenValueNamed: #'line-height');
					yourself ].

		self
			when: ToDisabledLookEvent
			write: (self property: #'text-attributes-with-builder')
			with: [ :e |
				e textAttributesBuilder foreground:
					(e tokenValueNamed: #'color-text-disabled') ].

		self select: #H1 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e tokenValueNamed: #'font-size-H1');
						lineSpacing: (e tokenValueNamed: #'line-height-H1');
						yourself ] ].

		self select: #H2 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e tokenValueNamed: #'font-size-H2');
						lineSpacing: (e tokenValueNamed: #'line-height-H2');
						yourself ] ].

		self select: #H3 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e tokenValueNamed: #'font-size-H3');
						lineSpacing: (e tokenValueNamed: #'line-height-H3');
						yourself ] ].

		self select: #H4 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e tokenValueNamed: #'font-size-H4');
						lineSpacing: (e tokenValueNamed: #'line-height-H4');
						yourself ] ].

		self select: #H5 asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						defaultFontSize: (e tokenValueNamed: #'font-size-H5');
						lineSpacing: (e tokenValueNamed: #'line-height-H5');
						yourself ] ].

		self select: #default asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e tokenValueNamed: #'color-text');
						yourself ] ].

		self select: #danger asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e tokenValueNamed: #'color-error');
						yourself ] ].

		self select: #link asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e tokenValueNamed: #'color-link');
						yourself ] ].

		self select: #primary asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e tokenValueNamed: #'color-text-light-solid');
						yourself ] ].

		self select: #secondary asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e tokenValueNamed: #'color-text-secondary');
						yourself ] ].

		self select: #success asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e tokenValueNamed: #'color-success');
						yourself ] ].

		self select: #warning asStampSelector style: [
			self
				supplement: (self property: #'text-attributes-with-builder')
				with: [ :e |
					e textAttributesBuilder
						foreground: (e tokenValueNamed: #'color-warning');
						yourself ] ] ]
]

{ #category : 'rules declaring - button' }
ToBeeTheme >> declareLabeledIconInButtonRules [

	self
		select: (#'labeled-icon' asStampSelector
				 withParent: #button asStampSelector
				 atDepth: 1)
		style: [
			self
				write: (self property: #layout)
				with: BlLinearLayout horizontal.

			self write: (self property: #'layout-constraints') with: [ :e |
				[ :c |
				c horizontal fitContent.
				c vertical fitContent.
				c linear vertical alignCenter.
				c linear horizontal alignCenter ] ].

			" without justification "
			self
				select:
				(self withParent: #flexible asStampSelector atDepth: 1) not
				style: [
					self write: (self property: #'layout-constraints') with: [ :e |
						[ :c |
						c frame vertical alignCenter.
						c frame horizontal alignCenter.
						c linear vertical alignCenter.
						c linear horizontal alignCenter ] ] ].

			" with justification: innerElement is matchParent if it has a parent with #justified "
			self
				select: (self withParent: #flexible asStampSelector atDepth: 1)
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

{ #category : 'rules declaring - button' }
ToBeeTheme >> declarePrimaryButtonRules [

	| backgroundColorAnim |
	" the animation must be shared by all writers which are using it to stop it correctly "
	backgroundColorAnim := ToPropertyColorTransitionAnimation new
		                       duration: 150 milliSeconds.

	"Button background and border"
	self
		select: self buttonSelector && #primary asStampSelector
		style: [ "Background"
			self
				when: ToInstallLookEvent
				write: (self property: #'background-color')
				with: [ :e | e tokenValueNamed: #'color-primary' ].
			self
				when: ToLeavedLookEvent
				write: (self property: #'background-color')
				with: [ :e | e tokenValueNamed: #'color-primary' ]
				animation: backgroundColorAnim.
			self
				when: ToDisabledLookEvent
				write: (self property: #'background-color')
				with: [ :e | e tokenValueNamed: #'color-bg-container-disabled' ].
			self
				when: ToHoveredLookEvent
				write: (self property: #'background-color')
				with: [ :e | e tokenValueNamed: #'color-primary-hover' ]
				animation: backgroundColorAnim.
			self
				when: ToPressedLookEvent
				write: (self property: #'background-color')
				with: [ :e | e tokenValueNamed: #'color-primary-pressed' ]
				animation: backgroundColorAnim.

			"Border"
			self
				when: ToInstallLookEvent
				write: (self property: #'border-with-builder')
				with: [ :e |
					e borderBuilder
						paint: Color transparent;
						width: (e tokenValueNamed: #'line-width') ].
			self
				when: ToLeavedLookEvent
				write: (self property: #'border-with-builder')
				with: [ :e |
					e borderBuilder
						paint: Color transparent;
						width: (e tokenValueNamed: #'line-width') ].
			self
				when: ToDisabledLookEvent
				write: (self property: #'border-with-builder')
				with: [ :e |
					e borderBuilder
						paint: (e tokenValueNamed: #'color-border-disabled');
						width: (e tokenValueNamed: #'line-width') ].

			"Label"
			self
				when: ToInstallLookEvent
				write: (self property: #'button-label-text-foreground')
				with: [ :e | e tokenValueNamed: #'color-text-light-solid' ].
			self
				when: ToLeavedLookEvent
				write: (self property: #'button-label-text-foreground')
				with: [ :e | e tokenValueNamed: #'color-text-light-solid' ].
			self
				when: ToDisabledLookEvent
				write: (self property: #'button-label-text-foreground')
				with: [ :e | e tokenValueNamed: #'color-text-disabled' ].
			self
				when: ToHoveredLookEvent
				write: (self property: #'button-label-text-foreground')
				with: [ :e | e tokenValueNamed: #'color-text-light-solid' ].
			self
				when: ToPressedLookEvent
				write: (self property: #'button-label-text-foreground')
				with: [ :e | e tokenValueNamed: #'color-text-light-solid' ] ]
]

{ #category : 'rules declaring - pane' }
ToBeeTheme >> declareRootPaneRules [

	self select: (self id: #'Space root') style: [
		self
			write: (self property: #background)
			with: [ :e | e tokenValueNamed: #'background-color' ] ]
]

{ #category : 'initialization' }
ToBeeTheme >> defaultElementStampsFor: anElement [ 

	^ anElement defaultBeeStyleStamps
]

{ #category : 'initialization' }
ToBeeTheme >> initializeStyleRules [ 

	super initializeStyleRules.
	self declareRootPaneRules.
	self declareLabelRules.
	self declareButtonRules
]

{ #category : 'styling' }
ToBeeTheme >> skinClassFor: anElement [

	^ ToBeeSkin
]
