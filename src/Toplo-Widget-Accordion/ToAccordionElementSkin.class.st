Class {
	#name : #ToAccordionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'event handling' }
ToAccordionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e hasStamp: #borderless) ifFalse: [
			e border: ((e valueOfTokenNamed: #'border-paint')) ].
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')) ]
]
