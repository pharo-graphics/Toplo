Class {
	#name : #ToAccordionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'event handling' }
ToAccordionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]
