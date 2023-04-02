"
https://ant.design/docs/spec/introduce
"
Class {
	#name : #ToTheme,
	#superclass : #ToAbstractTheme,
	#category : #'Toplo-LookAndFeel-ToTheme-Themes'
}

{ #category : #testing }
ToTheme class >> isAbstract [

	^ self = ToTheme
]

{ #category : #skins }
ToTheme class >> skinClassesFor: aToElementClass [
	"return skins which are designed for this theme"

	| oc |
	oc := OrderedCollection new.
	
	aToElementClass = ToButton ifTrue:[
		^ oc add: ToDefaultButtonSkin; add: ToPrimaryButtonSkin; add: ToDashedButtonSkin; add: ToTextButtonSkin; add: ToLinkButtonSkin; yourself.
	].

	aToElementClass = ToLabel ifTrue:[
		^ oc add: ToDefaultLabelSkin; add: ToLinkLabelSkin; add: ToPrimaryLabelSkin; add: ToH1LabelSkin; add: ToH2LabelSkin; add: ToH3LabelSkin; add: ToH4LabelSkin; add: ToH5LabelSkin; yourself.
	].

	^ oc
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
ToTheme >> colorLink [
	"https://ant.design/components/button#design-token"

	^ Color fromHexString: '#1677ff'
]

{ #category : #colors }
ToTheme >> colorLinkHover [
	"Control the color of hyperlink when hovering"

	^ Color fromHexString: '#69b1ff'
]

{ #category : #colors }
ToTheme >> colorPrimary [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#1677ff'
]

{ #category : #colors }
ToTheme >> colorPrimaryHover [
	"Hover state under the main color gradient"
	
	^ Color fromHexString: '#4096ff'
]

{ #category : #colors }
ToTheme >> colorText [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.88
]

{ #category : #colors }
ToTheme >> colorTextLightSolid [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#ffffff'
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
