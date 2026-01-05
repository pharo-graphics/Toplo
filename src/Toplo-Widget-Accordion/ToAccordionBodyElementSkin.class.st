Class {
	#name : #ToAccordionBodyElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #'event handling' }
ToAccordionBodyElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e content padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'padding-content-HS')
				 vertical: (e valueOfTokenNamed: #'padding-content-V')) ]
]
