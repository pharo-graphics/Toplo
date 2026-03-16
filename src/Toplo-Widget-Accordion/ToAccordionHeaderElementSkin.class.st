Class {
	#name : #ToAccordionHeaderElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e padding: (BlInsets
					 horizontal: (e valueOfTokenNamed: #'padding-content-HS')
					 vertical: (e valueOfTokenNamed: #'padding-content-V')).
			e geometry: (BlRoundedRectangleGeometry cornerRadius:
					 (e valueOfTokenNamed: 'border-radius')).
			(e parent hasStamp: #ghost) ifFalse: [
				e background: (e valueOfTokenNamed: #'color-secondary-selection') ] ]
]
