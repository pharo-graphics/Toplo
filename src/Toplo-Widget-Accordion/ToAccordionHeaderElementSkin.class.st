Class {
	#name : #ToAccordionHeaderElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'as yet unclassified' }
ToAccordionHeaderElementSkin >> clickedSkinEvent: anEvent [

	super clickedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := e isCollapsed
			           ifTrue: [ #'submenu-arrow-up' ]
			           ifFalse: [ #'submenu-arrow-down' ].
		e icon: (e valueOfTokenNamed: arrowTk) value ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := e isCollapsed
			           ifTrue: [ #'submenu-arrow-up' ]
			           ifFalse: [ #'submenu-arrow-down' ].
		e icon: (e valueOfTokenNamed: arrowTk) value ]
]
