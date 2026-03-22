Class {
	#name : #ToAccordionHeaderElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e removeTokenNamed: #'selected-focused-foreground'.
			e removeTokenNamed: #'selected-unfocused-foreground' ]
]

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
				"e background: (e valueOfTokenNamed: #'color-secondary-selection')" ] ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e
				addTokenNamed: #'selected-focused-foreground'
				withValue: (e valueOfTokenNamed: #'color-text').
			e
				addTokenNamed: #'selected-unfocused-foreground'
				withValue: (e valueOfTokenNamed: #'color-text') ]
]
