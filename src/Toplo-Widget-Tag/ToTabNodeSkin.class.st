Class {
	#name : #ToTabNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]
