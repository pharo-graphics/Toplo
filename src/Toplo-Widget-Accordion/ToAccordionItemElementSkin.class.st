Class {
	#name : #ToAccordionItemElementSkin,
	#superclass : #ToAccordionBaseElementSkin,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'event handling' }
ToAccordionItemElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e | e isExpanded: false ]
]

{ #category : #'event handling' }
ToAccordionItemElementSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e | e isExpanded: true ]
]
