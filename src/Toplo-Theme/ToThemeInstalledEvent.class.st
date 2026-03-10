Class {
	#name : #ToThemeInstalledEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Theme-Theme'
}

{ #category : #sending }
ToThemeInstalledEvent >> sendTo: anObject [

	anObject themeInstalledEvent: self
]
