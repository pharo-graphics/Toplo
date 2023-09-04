"
ToTheme is the mother Abstract Class for the default Toplo Theme.
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
	#name : #ToTheme,
	#superclass : #ToAbstractTheme,
	#instVars : [
		'colorPrimary'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #constructor }
ToTheme class >> blue [

	^ ToThemeLight new
]

{ #category : #customization }
ToTheme class >> colorPrimary: aColor [

	| theme |
	theme := ToThemeLight new.
	theme colorPrimary: aColor.
	^theme
]

{ #category : #customization }
ToTheme class >> colorPrimaryDark: aColor [

	| theme |
	theme := ToThemeDark new.
	theme colorPrimary: aColor.
	^theme
]

{ #category : #constructor }
ToTheme class >> darkBlue [

	^ ToThemeDark new
]

{ #category : #constructor }
ToTheme class >> darkGreen [

	^self colorPrimaryDark: (Color fromHexString: '#00B96B')
]

{ #category : #constructor }
ToTheme class >> darkPink [

	^self colorPrimaryDark: (Color fromHexString: '#ED4192')
]

{ #category : #constructor }
ToTheme class >> green [

	^self colorPrimary: (Color fromHexString: '#00B96B')
]

{ #category : #testing }
ToTheme class >> isAbstract [

	^ self = ToTheme
]

{ #category : #constructor }
ToTheme class >> pink [

	^self colorPrimary: (Color fromHexString: '#ED4192')
]

{ #category : #colors }
ToTheme >> backgroundColor [

	^ Color white
]

{ #category : #border }
ToTheme >> borderRadius [
	"https://ant.design/components/button#design-token"
	
	^ 6
]

{ #category : #border }
ToTheme >> borderRadiusLG [
	"https://ant.design/components/button#design-token"
	
	^ 8
]

{ #category : #border }
ToTheme >> borderRadiusSM [
	"https://ant.design/components/button#design-token"
	
	^ 4
]

{ #category : #colors }
ToTheme >> colorBgContainer [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#ffffff'
]

{ #category : #colors }
ToTheme >> colorBgContainerChecked [
	
	^ self colorPrimary
]

{ #category : #colors }
ToTheme >> colorBgContainerCheckedHover [
	
	^ self colorPrimaryHover
]

{ #category : #colors }
ToTheme >> colorBgContainerCheckedPressed [
	
	^ self colorPrimary darker
]

{ #category : #colors }
ToTheme >> colorBgContainerDisabled [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.04 
]

{ #category : #colors }
ToTheme >> colorBgContainerUnchecked [
	
	^ Color gray alpha: 0.6
]

{ #category : #colors }
ToTheme >> colorBgContainerUncheckedHover [
	
	^ Color gray alpha: 0.4
]

{ #category : #colors }
ToTheme >> colorBgTextActive [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.15 
]

{ #category : #colors }
ToTheme >> colorBgTextHover [
	"Control the background color of text in hover state"

	^ (Color r: 0 g: 0 b: 0 alpha: 0.2) 
]

{ #category : #colors }
ToTheme >> colorBorder [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#d9d9d9'
]

{ #category : #colors }
ToTheme >> colorBorderDisabled [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.2 
]

{ #category : #colors }
ToTheme >> colorError [
	"Used to represent the visual elements of the operation failure, such as the error Button, error Result component, etc."

	^ Color fromHexString: '#ff4d4f'
]

{ #category : #colors }
ToTheme >> colorErrorActive [
	"The active state of the error color"

	^ Color fromHexString: '#d9363e'
]

{ #category : #colors }
ToTheme >> colorErrorBg [
	"The background color of the error state"

	^ Color fromHexString: '#fff2f0'
]

{ #category : #colors }
ToTheme >> colorErrorHover [
	"The hover state of the error color"

	^ Color fromHexString: '#ff7875'
]

{ #category : #colors }
ToTheme >> colorErrorPressed [
	"The pressed state of the error color"

	^ (Color fromHexString: '#ff7875') darker darker
]

{ #category : #colors }
ToTheme >> colorImage [
	
	^ self colorText
]

{ #category : #colors }
ToTheme >> colorImageDisabled [
	
	^ Color r: 0.7 g: 0.7 b: 0.7 alpha: 1.0
]

{ #category : #colors }
ToTheme >> colorImageLightSolid [
	
	^ self colorTextLightSolid
]

{ #category : #colors }
ToTheme >> colorLink [
	"https://ant.design/components/button#design-token"

	^ Color fromHexString: '#1677ff'
]

{ #category : #colors }
ToTheme >> colorLinkActive [
	"Control the color of hyperlink when clicked"

	^ Color fromHexString: '#0958d9'
]

{ #category : #colors }
ToTheme >> colorLinkHover [
	"Control the color of hyperlink when hovering"

	^ Color fromHexString: '#69b1ff'
]

{ #category : #colors }
ToTheme >> colorPrimary [
	"Brand color is one of the most direct visual elements to reflect the characteristics and communication of the product. After you have selected the brand color, we will automatically generate a complete color palette and assign it effective design semantics"
	
	^ colorPrimary ifNil:[ colorPrimary := self defaultColorPrimary ]
]

{ #category : #settings }
ToTheme >> colorPrimary: aColor [
	"Brand color is one of the most direct visual elements to reflect the characteristics and communication of the product. After you have selected the brand color, we will automatically generate a complete color palette and assign it effective design semantics"
	
	colorPrimary = aColor ifTrue:[ ^ self ].
	colorPrimary := aColor
]

{ #category : #colors }
ToTheme >> colorPrimaryHover [
	"Hover state under the main color gradient"
	
	^ self colorPrimary whiter
]

{ #category : #colors }
ToTheme >> colorPrimaryPressed [
	"Hover state under the main color gradient"
	
	^ self colorPrimary darker darker
]

{ #category : #colors }
ToTheme >> colorSuccess [
	"Used to represent the token sequence of operation success, such as Result, Progress and other components will use these map tokens"

	^ Color fromHexString: '#52c41a'
]

{ #category : #colors }
ToTheme >> colorText [
	"Default text color which comply with W3C standards, and this color is also the darkest neutral color."
	
	^ Color r: 0.0 g: 0.0 b: 0.0 "alpha: 0.88"
]

{ #category : #colors }
ToTheme >> colorTextDescription [
	"Control the font color of text description"

	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.45
]

{ #category : #colors }
ToTheme >> colorTextDisabled [
	"Control the color of text in disabled state"

	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.25
]

{ #category : #colors }
ToTheme >> colorTextHeading [
	"Control the font color of heading"

	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.88
]

{ #category : #colors }
ToTheme >> colorTextLightSolid [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#ffffff'
]

{ #category : #colors }
ToTheme >> colorTextSecondary [
	"Default text color which comply with W3C standards, and this color is also the darkest neutral color."
	
	^ Color black alpha: 0.45
]

{ #category : #colors }
ToTheme >> colorWarning [
	"Used to represent the warning map token, such as Notification, Alert, etc. Alert or Control component(like Input) will use these map tokens"

	^ Color fromHexString: '#faad14'
]

{ #category : #sizes }
ToTheme >> controlHeight [
	"The height of the basic controls such as buttons and input boxes in Ant Design"

	^ 32
]

{ #category : #sizes }
ToTheme >> controlHeightLG [
	"The height of the basic controls such as buttons and input boxes in Ant Design"

	^ 40
]

{ #category : #sizes }
ToTheme >> controlHeightSM [
	"The height of the basic controls such as buttons and input boxes in Ant Design"

	^ 24
]

{ #category : #colors }
ToTheme >> darkTheme [

	^ nil
]

{ #category : #border }
ToTheme >> dashArray [
	"dashed rendering equivalent in web UI"
	
	^ #( 3 3 )
]

{ #category : #settings }
ToTheme >> defaultColorPrimary [

	^ Color fromHexString: '#1677ff'
]

{ #category : #text }
ToTheme >> fontFamilyCode [
	"https://ant.design/components/typography#design-token"

	"^ #( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )"
	^ 'SFMono-Regular'
]

{ #category : #text }
ToTheme >> fontSize [
	"https://ant.design/components/typography#design-token"

	^ 14
]

{ #category : #text }
ToTheme >> fontSizeHeading1 [
	"Font size of h1 tag"

	^ 38
]

{ #category : #text }
ToTheme >> fontSizeHeading2 [
	"Font size of h2 tag"

	^ 30
]

{ #category : #text }
ToTheme >> fontSizeHeading3 [
	"Font size of h3 tag"

	^ 24
]

{ #category : #text }
ToTheme >> fontSizeHeading4 [
	"Font size of h4 tag"

	^ 20
]

{ #category : #text }
ToTheme >> fontSizeHeading5 [
	"Font size of h5 tag"

	^ 16
]

{ #category : #text }
ToTheme >> fontWeightStrong [
	"https://ant.design/components/typography#design-token"

	^ 600
]

{ #category : #colors }
ToTheme >> isDark [

	^ false
]

{ #category : #colors }
ToTheme >> isLight [

	^ false
]

{ #category : #colors }
ToTheme >> lightTheme [

	^ nil
]

{ #category : #text }
ToTheme >> lineHeight [
	"https://ant.design/components/typography#design-token"

	^ 1.5
]

{ #category : #text }
ToTheme >> lineHeightHeading1 [
	"Line height of h1 tag"

	^ 1.2
]

{ #category : #text }
ToTheme >> lineHeightHeading2 [
	"Line height of h2 tag"

	^ 1.3
]

{ #category : #text }
ToTheme >> lineHeightHeading3 [
	"Line height of h3 tag"

	^ 1.3
]

{ #category : #text }
ToTheme >> lineHeightHeading4 [
	"Line height of h4 tag"

	^ 1.4
]

{ #category : #text }
ToTheme >> lineHeightHeading5 [
	"Line height of h5 tag"

	^ 1.5
]

{ #category : #border }
ToTheme >> lineType [
	"https://ant.design/components/button#design-token"
	
	^ #solid
]

{ #category : #border }
ToTheme >> lineWidth [
	"https://ant.design/components/button#design-token"
	
	^ 1
]

{ #category : #border }
ToTheme >> lineWidthFocus [
	"https://ant.design/components/button#design-token"
	
	^ 4
]

{ #category : #sizes }
ToTheme >> paddingContentHorizontal [
	"Control the horizontal padding of content element"

	^ 16
]

{ #category : #sizes }
ToTheme >> paddingContentVertical [
	"Control the vertical padding of content element"

	^ 8
]

{ #category : #sizes }
ToTheme >> paddingXS [
	"Control the extra small padding of the element"

	^ 8
]

{ #category : #images }
ToTheme >> radioCheckedImageIn: anElement [

	^ (self checkboxCheckedImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]

{ #category : #images }
ToTheme >> radioDisabledImageIn: anElement [

	^ (self checkboxDisabledImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]

{ #category : #images }
ToTheme >> radioIndeterminateImageIn: anElement [

	^ (self checkboxIndeterminateImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]

{ #category : #images }
ToTheme >> radioUncheckedImageIn: anElement [

	^ (self checkboxUncheckedImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]
