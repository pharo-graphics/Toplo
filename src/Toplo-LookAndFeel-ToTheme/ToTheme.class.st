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
		^ oc add: ToDefaultLabelSkin; add: ToLinkLabelSkin; add: ToPrimaryLabelSkin; yourself.
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
ToTheme >> fontWeightStrong [
	"https://ant.design/components/typography#design-token"

	^ 600
]

{ #category : #text }
ToTheme >> lineHeight [
	"https://ant.design/components/typography#design-token"

	^ 1
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
