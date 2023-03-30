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
ToClearTheme >> colorPrimary [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#1677ff'
]
