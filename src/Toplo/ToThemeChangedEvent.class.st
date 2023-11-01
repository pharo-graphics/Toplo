Class {
	#name : #ToThemeChangedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Core-Skin'
}

{ #category : #sending }
ToThemeChangedEvent >> sendTo: anObject [

	anObject themeChangedEvent: self
]
