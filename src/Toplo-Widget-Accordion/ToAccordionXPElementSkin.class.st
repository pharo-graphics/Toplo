Class {
	#name : #ToAccordionXPElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion-XP'
}

{ #category : #'event handling' }
ToAccordionXPElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | "
				(e hasIcon and: [ e hasLabel ])
					ifTrue: [
					e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
					ifFalse: [ e startInterspace: 0 ] ]"
		| arrowTk |
		e endFlexible: true.
		e endInterspace: (e valueOfTokenNamed: #'menu-item-start-alignment').
		arrowTk := e isCollapsed
			           ifTrue: [ #'submenu-arrow-up' ]
			           ifFalse: [ #'submenu-arrow-down' ].
		e endElement: (e valueOfTokenNamed: arrowTk) value ]
]

{ #category : #'event handling' }
ToAccordionXPElementSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := e isCollapsed
			           ifTrue: [ #'submenu-arrow-up' ]
			           ifFalse: [ #'submenu-arrow-down' ].
		e endElement removeFromParent.
		e endElement: (e valueOfTokenNamed: arrowTk) value ]
]
