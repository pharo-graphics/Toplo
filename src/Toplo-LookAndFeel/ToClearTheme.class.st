Class {
	#name : #ToClearTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-LookAndFeel-Theme'
}

{ #category : #colors }
ToClearTheme >> colorBgContainer [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#ffffff'
]

{ #category : #colors }
ToClearTheme >> colorBgTextActive [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.15 
]

{ #category : #colors }
ToClearTheme >> colorBorder [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#d9d9d9'
]

{ #category : #colors }
ToClearTheme >> colorPrimary [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#1677ff'
]

{ #category : #colors }
ToClearTheme >> colorText [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.88
]

{ #category : #colors }
ToClearTheme >> colorTextLightSolid [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#ffffff'
]
