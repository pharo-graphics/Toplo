"
https://ant.design/docs/spec/dark

Dark mode is a theme where all UI elements are darkened.

When to use ?

    Dark mode is recommended when you are in a dark environment as it prevents eye strain.
    Dark mode is great for highlighting important content

        It works similarly to turning off the lights in a movie theater.
"
Class {
	#name : #ToDefaultThemeDark,
	#superclass : #ToDefaultTheme,
	#category : 'Toplo-Theme-DefaultTheme'
}

{ #category : #colors }
ToDefaultThemeDark >> backgroundColor [

	^ Color black
]

{ #category : #colors }
ToDefaultThemeDark >> colorBgContainer [

	^ Color fromHexString: '#1b1b1b'
]

{ #category : #colors }
ToDefaultThemeDark >> colorBgContainerDisabled [

	^ Color white alpha: 0.15
]

{ #category : #colors }
ToDefaultThemeDark >> colorBgTextActive [
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.15 
]

{ #category : #colors }
ToDefaultThemeDark >> colorBgTextHover [

	^ Color r: 255 g: 255 b: 255 alpha: 0.30
]

{ #category : #colors }
ToDefaultThemeDark >> colorBorder [

	^ Color fromHexString: '#a6a6a6'
]

{ #category : #colors }
ToDefaultThemeDark >> colorBorderDisabled [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.7 g: 0.7 b: 0.7 alpha: 0.5
]

{ #category : #colors }
ToDefaultThemeDark >> colorErrorBg [
	"The background color of the error state"

	^ Color fromHexString: '#2a1215'
]

{ #category : #colors }
ToDefaultThemeDark >> colorImageDisabled [
	
	^ Color r: 0.7 g: 0.7 b: 0.7 alpha: 1.0
]

{ #category : #colors }
ToDefaultThemeDark >> colorText [
	
	^ Color r: 255 g: 255 b: 255 "alpha: 0.88 "
]

{ #category : #colors }
ToDefaultThemeDark >> colorTextDisabled [
	"Control the color of text in disabled state"

	^ Color r: 0.7 g: 0.7 b: 0.7 alpha: 0.5
]

{ #category : #colors }
ToDefaultThemeDark >> colorTextHeading [

	^ Color r: 255 g: 255 b: 255 alpha: 0.88
]

{ #category : #colors }
ToDefaultThemeDark >> colorTextSecondary [
	
	^ Color white alpha: 0.45
]

{ #category : #colors }
ToDefaultThemeDark >> darkTheme [

	^ self
]

{ #category : #colors }
ToDefaultThemeDark >> initialize [ 

	super initialize.
	self name: 'Toplo Dark'.
]

{ #category : #colors }
ToDefaultThemeDark >> isDark [

	^ true
]

{ #category : #colors }
ToDefaultThemeDark >> isLight [

	^ false
]

{ #category : #colors }
ToDefaultThemeDark >> lightTheme [

	^ self class colorPrimary: self colorPrimary
]
