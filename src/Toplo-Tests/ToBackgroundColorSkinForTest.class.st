Class {
	#name : #ToBackgroundColorSkinForTest,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #'event handling' }
ToBackgroundColorSkinForTest >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.

	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'background-color') ]
]
