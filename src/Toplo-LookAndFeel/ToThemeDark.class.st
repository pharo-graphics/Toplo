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
	#category : #'Toplo-LookAndFeel-Theme'
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
ToThemeDark >> colorBgContainerDisabled [

	^ Color white alpha: 0.15
]

{ #category : #colors }
ToThemeDark >> colorBgTextActive [
	
	^ Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.15 
]

{ #category : #colors }
ToThemeDark >> colorBgTextHover [

	^ Color r: 255 g: 255 b: 255 alpha: 0.06
]

{ #category : #colors }
ToThemeDark >> colorBorder [

	^ Color fromHexString: '#a6a6a6'
]

{ #category : #colors }
ToThemeDark >> colorBorderDisabled [
	"https://ant.design/components/button#design-token"
	
	^ Color r: 0.7 g: 0.7 b: 0.7 alpha: 0.5
]

{ #category : #colors }
ToThemeDark >> colorErrorBg [
	"The background color of the error state"

	^ Color fromHexString: '#2a1215'
]

{ #category : #colors }
ToThemeDark >> colorImageDisabled [
	
	^ Color r: 0.7 g: 0.7 b: 0.7 alpha: 1.0
]

{ #category : #colors }
ToThemeDark >> colorText [
	
	^ Color r: 255 g: 255 b: 255 "alpha: 0.88 "
]

{ #category : #colors }
ToThemeDark >> colorTextDisabled [
	"Control the color of text in disabled state"

	^ Color r: 0.7 g: 0.7 b: 0.7 alpha: 0.5
]

{ #category : #colors }
ToThemeDark >> colorTextHeading [

	^ Color r: 255 g: 255 b: 255 alpha: 0.88
]

{ #category : #colors }
ToThemeDark >> colorTextSecondary [
	
	^ Color white alpha: 0.45
]

{ #category : #colors }
ToThemeDark >> darkTheme [

	^ self
]

{ #category : #colors }
ToThemeDark >> initialize [ 

	super initialize.
	self name: 'Toplo Dark'.
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

	^ self class colorPrimary: self colorPrimary
]
