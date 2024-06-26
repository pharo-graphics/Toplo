Class {
	#name : #ToBarNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToBarNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent.
		e padding: (BlInsets all: 3) ]
]
