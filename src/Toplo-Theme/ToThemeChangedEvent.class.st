Class {
	#name : #ToThemeChangedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Theme-Core'
}

{ #category : #sending }
ToThemeChangedEvent >> sendTo: anObject [

	anObject themeChangedEvent: self
]
