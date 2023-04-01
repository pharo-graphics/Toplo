"
https://ant.design/docs/spec/dark

Dark mode is a theme where all UI elements are darkened.

When to use ?

    Dark mode is recommended when you are in a dark environment as it prevents eye strain.
    Dark mode is great for highlighting important content

        It works similarly to turning off the lights in a movie theater.
"
Class {
	#name : #ToThemeDark,
	#superclass : #ToTheme,
	#category : #'Toplo-LookAndFeel-ToTheme-Themes'
}

{ #category : #colors }
ToThemeDark >> backgroundColor [

	^ Color black
]

{ #category : #colors }
ToThemeDark >> colorBgContainer [

	^ Color fromHexString: '#1b1b1b'
]

{ #category : #colors }
ToThemeDark >> colorBgTextActive [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.15 
]

{ #category : #colors }
ToThemeDark >> colorBorder [
	"https://ant.design/components/button#design-token"
	
	^ Color fromHexString: '#a6a6a6'
]

{ #category : #colors }
ToThemeDark >> colorPrimary [
	
	^ Color fromHexString: '#1677ff'
]

{ #category : #colors }
ToThemeDark >> colorText [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 255 g: 255 b: 255 alpha: 0.88 
]

{ #category : #colors }
ToThemeDark >> darkTheme [

	^ self
]

{ #category : #colors }
ToThemeDark >> initialize [ 

	super initialize.
	self name: 'Toplo dark Theme'
]

{ #category : #colors }
ToThemeDark >> isDark [

	^ true
]

{ #category : #colors }
ToThemeDark >> isLight [

	^ false
]

{ #category : #colors }
ToThemeDark >> lightTheme [

	^ ToThemeLight new
]
