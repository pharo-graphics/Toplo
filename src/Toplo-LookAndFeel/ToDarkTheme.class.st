Class {
	#name : #ToDarkTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-LookAndFeel-Theme'
}

{ #category : #colors }
ToDarkTheme >> colorBgContainer [
	"https://ant.design/components/button#design-token"
	
	"^ Color fromHexString: '#ffffff'"
	^ Color black
]

{ #category : #colors }
ToDarkTheme >> colorPrimary [
	"https://ant.design/components/button#design-token"
	
	^ Color cyan 
]
