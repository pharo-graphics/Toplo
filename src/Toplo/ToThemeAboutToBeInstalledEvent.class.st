Class {
	#name : #ToThemeAboutToBeInstalledEvent,
	#superclass : #BlEvent,
	#instVars : [
		'theme'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #accessing }
ToThemeAboutToBeInstalledEvent >> theme [

	^ theme
]

{ #category : #accessing }
ToThemeAboutToBeInstalledEvent >> theme: aTheme [

	theme := aTheme
]
