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

{ #category : 'accessing' }
ToBeeTheme class >> defaultColorPrimary [

	^ Color fromHexString: '#1677ff'
]

{ #category : 'initialization' }
ToBeeTheme >> defaultElementStampsFor: anElement [ 

	^ anElement defaultBeeStyleStamps
]

{ #category : 'styling' }
ToBeeTheme >> newStyleSheet [ 

	^ ToBeeStyleSheet new
]

{ #category : 'styling' }
ToBeeTheme >> skinClassFor: anElement [

	^ ToBeeSkin
]
