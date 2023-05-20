"
ToTheme is the mother Abstract Class for the default Toplo Theme.
This theme is inpired by Ant (https://ant.design/docs/spec/introduce).
This theme exists in two variants : light (by default) and dark.
This theme can be derive using ""primaryColor"" properties to create color variants.
"
Class {
	#name : #ToTheme,
	#superclass : #ToAbstractTheme,
	#instVars : [
		'colorPrimary'
	],
	#category : #'Toplo-LookAndFeel-Theme'
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

{ #category : #skins }
ToTheme class >> skinClassesFor: aToElementClass [
	"return skins which are designed for this theme"

	| set |
	set := OrderedSet new.
	
	aToElementClass = ToButton ifTrue:[
		"Set default skin"
		set add: ToDefaultButtonSkin.
		set addAll: ToThemeButtonSkin allSubclasses.
	].

	aToElementClass = ToLabel ifTrue:[
		"Set default skin"
		set add: ToDefaultLabelSkin.
		set addAll: ToThemeLabelSkin allSubclasses.
	].

	aToElementClass = ToImage ifTrue:[
		"Set default skin"
		set add: ToDefaultImageSkin.
		set addAll: ToThemeImageSkin allSubclasses.
	].

	^ set asOrderedCollection
]

{ #category : #border }
ToTheme >> borderRadius [
	"https://ant.design/components/button#design-token"
	
	^ 6
]

{ #category : #colors }
ToTheme >> colorBgContainer [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#ffffff'
]

{ #category : #colors }
ToTheme >> colorBgTextActive [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.15 
]

{ #category : #colors }
ToTheme >> colorBgTextHover [
	"Control the background color of text in hover state"

	^ Color r: 0 g: 0 b: 0 alpha: 0.06
]

{ #category : #colors }
ToTheme >> colorBorder [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#d9d9d9'
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
ToTheme >> colorImage [
	"Default text color which comply with W3C standards, and this color is also the darkest neutral color."
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.88
]

{ #category : #colors }
ToTheme >> colorImageLightSolid [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#ffffff'
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
ToTheme >> colorSuccess [
	"Used to represent the token sequence of operation success, such as Result, Progress and other components will use these map tokens"

	^ Color fromHexString: '#52c41a'
]

{ #category : #colors }
ToTheme >> colorText [
	"Default text color which comply with W3C standards, and this color is also the darkest neutral color."
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.88
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

{ #category : #border }
ToTheme >> dashed [
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

{ #category : #text }
ToTheme >> initialize [ 
	
	super initialize
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

{ #category : #sizes }
ToTheme >> paddingContentHorizontal [
	"Control the horizontal padding of content element"

	^ 16
]

{ #category : #sizes }
ToTheme >> paddingXS [
	"Control the extra small padding of the element"

	^ 8
]
