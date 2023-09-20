Class {
	#name : 'ToThemeChangedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'sending' }
ToThemeChangedEvent >> sendTo: anObject [

	anObject themeChangedEvent: self
]
