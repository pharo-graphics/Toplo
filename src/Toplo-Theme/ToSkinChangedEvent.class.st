Class {
	#name : 'ToSkinChangedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Theme-Skin',
	#package : 'Toplo-Theme',
	#tag : 'Skin'
}

{ #category : 'sending' }
ToSkinChangedEvent >> sendTo: anObject [

	anObject skinChangedEvent: self
]
