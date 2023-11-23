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

{ #category : 'constructor' }
ToBeeTheme class >> blue [

	^ ToBeeLightTheme new
]

{ #category : 'customization' }
ToBeeTheme class >> colorPrimary: aColor [

	| theme |
	theme := ToBeeLightTheme new.
	theme colorPrimary: aColor.
	^theme
]

{ #category : 'customization' }
ToBeeTheme class >> colorPrimaryDark: aColor [

	| theme |
	theme := ToBeeDarkTheme new.
	theme colorPrimary: aColor.
	^theme
]

{ #category : 'constructor' }
ToBeeTheme class >> darkBlue [

	^ ToBeeDarkTheme new
]

{ #category : 'constructor' }
ToBeeTheme class >> darkGreen [

	^self colorPrimaryDark: (Color fromHexString: '#00B96B')
]

{ #category : 'constructor' }
ToBeeTheme class >> darkPink [

	^self colorPrimaryDark: (Color fromHexString: '#ED4192')
]

{ #category : 'constructor' }
ToBeeTheme class >> green [

	^self colorPrimary: (Color fromHexString: '#00B96B')
]

{ #category : 'constructor' }
ToBeeTheme class >> pink [

	^self colorPrimary: (Color fromHexString: '#ED4192')
]

{ #category : 'default stamp list accessing' }
ToBeeTheme >> checkboxBlankImage [

	| bar im |
	bar := ToElement new id: #bar.
	bar withoutSkin.
	bar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 3.
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	bar margin: (BlInsets left: 2 right: 2).
	bar geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	im := ToElement new.
	im layout: BlFrameLayout new.
	im size: 16 asPoint.
	im addChild: bar.
	im withoutSkin.
	bar withAllStamps: #( #bar ).
	im withAllStamps: #( #'inner-image' #unchecked ).
	^ im
]

{ #category : 'initialization' }
ToBeeTheme >> defaultColorPrimary [

	^ Color fromHexString: '#1677ff'
]

{ #category : 'initialization' }
ToBeeTheme >> defaultElementStampsFor: anElement [ 

	^ anElement defaultBeeStyleStamps
]

{ #category : 'default stamp list accessing' }
ToBeeTheme >> defaultReadOnlyStampList [
	" skin managing need a list of unique stamps . "

	^ {
		  (ToReadOnlyStyleStamp name: #'background-color' value: Color white).
		
		  (ToReadOnlyStyleStamp name: #'border-radius' value: 6).
		  (ToReadOnlyStyleStamp name: #'border-radius-LG' value: 8).
		  (ToReadOnlyStyleStamp name: #'border-radius-SM' value: 4).
		  (ToReadOnlyStyleStamp name: #'checkbox-image-builder' value: [ self checkboxBlankImage ] ).
		  (ToReadOnlyStyleStamp name: #'color-bg-container' value: (Color fromHexString: '#ffffff')).
		  (ToReadOnlyStyleStamp name: #'color-bg-container-disabled' value: (Color black alpha: 0.04)).
		  (ToReadOnlyStyleStamp name: #'color-bg-text-active' value: (Color black alpha: 0.15)).
		  (ToReadOnlyStyleStamp name: #'color-bg-text-hover' value: (Color black alpha: 0.2)).
		  (ToReadOnlyStyleStamp name: #'color-border' value: (Color fromHexString: '#d9d9d9')).
		  (ToReadOnlyStyleStamp name: #'color-border-checkable' value: Color transparent).
		  (ToReadOnlyStyleStamp name: #'color-border-disabled' value: (Color black alpha: 0.2)).
		  (ToReadOnlyStyleStamp name: #'color-error-bg' value: (Color fromHexString: '#fff2f0')).
		  (ToReadOnlyStyleStamp name: #'color-error-hover' value: (Color fromHexString: '#ff7875')).
		  (ToReadOnlyStyleStamp name: #'color-error-pressed' value: (Color fromHexString: '#e75c5d')).
		  (ToReadOnlyStyleStamp name: #'color-error' value: (Color fromHexString: '#ff4d4f')).
		  (ToReadOnlyStyleStamp name: #'color-image-disabled' value: (Color black alpha: 1.0)).
		  (ToReadOnlyStyleStamp name: #'color-image-light-solid' value: (Color fromHexString: '#ffffff')).

		  (ToReadOnlyStyleStamp name: #'color-link' value: (Color fromHexString: '#1677ff')).
		  (ToReadOnlyStyleStamp name: #'color-link-active' value: (Color fromHexString: '#0958d9')).
		  (ToReadOnlyStyleStamp name: #'color-link-hover' value: (Color fromHexString: '#69b1ff')).
		  (ToReadOnlyStyleStamp name: #'color-primary' value: (self defaultColorPrimary)).
		  (ToReadOnlyStyleStamp name: #'color-primary-pressed' value: self defaultColorPrimary twiceDarker ).
		  (ToReadOnlyStyleStamp name: #'color-primary-hover' value: self defaultColorPrimary twiceLighter ).
		  (ToReadOnlyStyleStamp name: #'color-success' value: (Color fromHexString: '#52c41a')).
		  (ToReadOnlyStyleStamp name: #'color-warning' value: (Color fromHexString: '#faad14')).
		
		  (ToReadOnlyStyleStamp name: #'color-text' value: (Color black)).
		  (ToReadOnlyStyleStamp name: #'color-text-description' value: (Color black alpha: 0.45)).
		  (ToReadOnlyStyleStamp name: #'color-text-disabled' value: (Color black alpha: 0.25)).
		  (ToReadOnlyStyleStamp name: #'color-text-heading' value: (Color black alpha: 0.88)).
		  (ToReadOnlyStyleStamp name: #'color-text-light-solid' value: (Color fromHexString: '#ffffff')).
		  (ToReadOnlyStyleStamp name: #'color-text-secondary' value: (Color black alpha: 0.45)).

		  (ToReadOnlyStyleStamp name: #'dash-array' value: #( 3 3 )).

		  "#( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )"
		  (ToReadOnlyStyleStamp name: #'font-family-code' value: 'SFMono-Regular').
		  (ToReadOnlyStyleStamp name: #'font-size' value: 14).
		  (ToReadOnlyStyleStamp name: #'font-size-H1' value: 38).
		  (ToReadOnlyStyleStamp name: #'font-size-H2' value: 30).
		  (ToReadOnlyStyleStamp name: #'font-size-H3' value: 24).
		  (ToReadOnlyStyleStamp name: #'font-size-H4' value: 20).
		  (ToReadOnlyStyleStamp name: #'font-size-H5' value: 16).
		  (ToReadOnlyStyleStamp name: #'font-weight-strong' value: 600).

		  (ToReadOnlyStyleStamp name: #'line-height' value: 1.5).
		  (ToReadOnlyStyleStamp name: #'line-height-H1' value: 1.2).
		  (ToReadOnlyStyleStamp name: #'line-height-H2' value: 1.3).
		  (ToReadOnlyStyleStamp name: #'line-height-H3' value: 1.3).
		  (ToReadOnlyStyleStamp name: #'line-height-H4' value: 1.4).
		  (ToReadOnlyStyleStamp name: #'line-height-H5' value: 1.5).

		  (ToReadOnlyStyleStamp name: #'line-type' value: #solid).
		  (ToReadOnlyStyleStamp name: #'line-width' value: 1).
		  (ToReadOnlyStyleStamp name: #'line-width-focus' value: 4).

			"Size, margin and padding"
		  (ToReadOnlyStyleStamp name: #'control-height' value: 32).
		  (ToReadOnlyStyleStamp name: #'control-height-LG' value: 40).
		  (ToReadOnlyStyleStamp name: #'control-height-SM' value: 24).

		  (ToReadOnlyStyleStamp name: #'margin-XS' value: 8). 

		  (ToReadOnlyStyleStamp name: #'padding-content-H' value: 15).
		  (ToReadOnlyStyleStamp name: #'padding-content-V' value: 4).
		  (ToReadOnlyStyleStamp name: #'padding-XS' value: 8) 
	}
]

{ #category : 'initialization' }
ToBeeTheme >> newStyleSheet [ 

	^ ToBeeStyleSheet new
]

{ #category : 'writer selecting' }
ToBeeTheme >> skinClassFor: anElement [

	^ ToBeeSkin
]
