Class {
	#name : 'ToRawSkin',
	#superclass : 'ToSkin',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'event handling' }
ToRawSkin >> installLookEvent: anEvent [

	anEvent elementDo: [ :e | e installRawStyle ]
]
