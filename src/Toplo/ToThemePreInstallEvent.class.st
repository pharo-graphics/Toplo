Class {
	#name : #ToThemePreInstallEvent,
	#superclass : #BlEvent,
	#instVars : [
		'theme'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #sending }
ToThemePreInstallEvent >> sendTo: anObject [

	anObject themePreInstallEvent: self
]

{ #category : #accessing }
ToThemePreInstallEvent >> theme [

	^ theme
]

{ #category : #accessing }
ToThemePreInstallEvent >> theme: aTheme [

	theme := aTheme
]
