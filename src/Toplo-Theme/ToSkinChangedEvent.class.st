Class {
	#name : 'ToSkinChangedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'sending' }
ToSkinChangedEvent >> sendTo: anObject [

	anObject skinChangedEvent: self
]
