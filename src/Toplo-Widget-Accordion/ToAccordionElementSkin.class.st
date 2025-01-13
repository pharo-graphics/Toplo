Class {
	#name : #ToAccordionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'event handling' }
ToAccordionElementSkin >> clickedSkinEvent: anEvent [

	super clickedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := e isCollapsed
			           ifTrue: [ #'submenu-arrow-up' ]
			           ifFalse: [ #'submenu-arrow-down' ].
		e icon: (e valueOfTokenNamed: arrowTk) value ]
]

{ #category : #'event handling' }
ToAccordionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := e isCollapsed
			           ifTrue: [ #'submenu-arrow-up' ]
			           ifFalse: [ #'submenu-arrow-down' ].
		e icon: (e valueOfTokenNamed: arrowTk) value ]
]
