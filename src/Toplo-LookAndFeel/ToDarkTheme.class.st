"
https://ant.design/docs/spec/dark

Dark mode is a theme where all UI elements are darkened.

When to use ?

    Dark mode is recommended when you are in a dark environment as it prevents eye strain.
    Dark mode is great for highlighting important content

        It works similarly to turning off the lights in a movie theater.
"
Class {
	#name : #ToDarkTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-LookAndFeel-Theme'
}

{ #category : #colors }
ToDarkTheme >> backgroundColor [

	^ Color black
]

{ #category : #colors }
ToDarkTheme >> colorBgContainer [

	^ Color fromHexString: '#1b1b1b'
]

{ #category : #colors }
ToDarkTheme >> colorBgTextActive [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.15 
]

{ #category : #colors }
ToDarkTheme >> colorBorder [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#d9d9d9'
]

{ #category : #colors }
ToDarkTheme >> colorPrimary [
	
	^ Color fromHexString: '#1677ff'
]

{ #category : #colors }
ToDarkTheme >> colorText [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.88 
]

{ #category : #colors }
ToDarkTheme >> initialize [ 

	super initialize.
	self name: 'Toplo dark Theme'
]

{ #category : #colors }
ToDarkTheme >> isDark [

	^ true
]

{ #category : #colors }
ToDarkTheme >> isLight [

	^ false
]
