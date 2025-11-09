Class {
	#name : #ToTableHeaderSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'event handling' }
ToTableHeaderSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e children do: #bold ]
]
