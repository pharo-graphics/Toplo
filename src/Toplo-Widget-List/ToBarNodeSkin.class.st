Class {
	#name : #ToBarNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToBarNodeSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: (BlInsets all: 3) ]
]
