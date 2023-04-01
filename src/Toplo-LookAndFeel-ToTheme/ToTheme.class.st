"
https://ant.design/docs/spec/introduce
"
Class {
	#name : #ToTheme,
	#superclass : #ToAbstractTheme,
	#category : #'Toplo-LookAndFeel-ToTheme-Themes'
}

{ #category : #testing }
ToTheme class >> default [

	^ ToThemeLight new
]

{ #category : #dresser }
ToTheme class >> dresserFor: aToElementClass [
	"return dresser which manage this theme"

	aToElementClass class = ToButton ifTrue: [ ^ ToLAFButtonDresser new ].
	aToElementClass class = ToLabel ifTrue: [ ^ ToLAFLabelDresser new ].

	^ aToElementClass defaultDresser
]

{ #category : #testing }
ToTheme class >> isAbstract [

	^ self = ToTheme
]

{ #category : #skins }
ToTheme class >> skinClassesFor: aToElementClass [
	"return skins which are designed for this theme"

	| oc |
	oc := OrderedCollection new.
	
	aToElementClass class = ToButton ifTrue:[
		^ oc add: ToDefaultButtonSkin; add: ToPrimaryButtonSkin; add: ToDashedButtonSkin; add: ToTextButtonSkin; add: ToLinkButtonSkin; yourself.
	].

	aToElementClass class = ToLabel ifTrue:[
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
ToTheme >> colorPrimary [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#1677ff'
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

{ #category : #text }
ToTheme >> fontFamilyCode [
	"https://ant.design/components/typography#design-token"

	^ #( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )
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

	^ 1.5714285714285714
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
