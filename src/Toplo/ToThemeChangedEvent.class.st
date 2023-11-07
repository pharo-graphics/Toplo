Class {
	#name : 'ToThemeChangedEvent',
	#superclass : 'ToSkinEvent',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'sending' }
ToThemeChangedEvent >> sendTo: anObject [

	anObject themeChangedEvent: self
]
