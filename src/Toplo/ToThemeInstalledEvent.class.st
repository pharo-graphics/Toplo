Class {
	#name : #ToThemeInstalledEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-Theme'
}

{ #category : #sending }
ToThemeInstalledEvent >> sendTo: anObject [

	anObject themeInstalledEvent: self
]
