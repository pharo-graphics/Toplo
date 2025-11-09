Class {
	#name : #ToTableHeaderLabelSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'event handling' }
ToTableHeaderLabelSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :headerLabel | headerLabel bold ]
]
