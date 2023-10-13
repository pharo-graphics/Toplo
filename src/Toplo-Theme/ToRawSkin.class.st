Class {
	#name : #ToRawSkin,
	#superclass : #ToSkin,
	#category : #'Toplo-Theme-Core'
}

{ #category : #'event handling' }
ToRawSkin >> installLookEvent: anEvent [

	anEvent elementDo: [ :e | e installRawStyle ]
]
