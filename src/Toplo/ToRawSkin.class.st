Class {
	#name : #ToRawSkin,
	#superclass : #ToSkin,
	#category : 'Toplo-Core-Skin'
}

{ #category : #'event handling' }
ToRawSkin >> installLookEvent: anEvent [

	anEvent elementDo: [ :e | e installRawStyle ]
]
