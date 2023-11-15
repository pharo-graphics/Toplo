Class {
	#name : 'ToThemeChangedEvent',
	#superclass : 'ToSkinEvent',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'sending' }
ToThemeChangedEvent >> sendTo: anObject [

	anObject themeChangedEvent: self
]
