Class {
	#name : #ToThemeChangedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Core-Theme'
}

{ #category : #sending }
ToThemeChangedEvent >> sendTo: anObject [

	anObject themeChangedEvent: self
]
