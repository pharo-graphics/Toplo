Class {
	#name : #ToAccordionItemHeaderElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'event handling' }
ToAccordionItemHeaderElementSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := #'submenu-arrow-down'.
		e icon: (e valueOfTokenNamed: arrowTk) value ]
]

{ #category : #'event handling' }
ToAccordionItemHeaderElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := e isCollapsed
			           ifTrue: [ #'submenu-arrow-up' ]
			           ifFalse: [ #'submenu-arrow-down' ].
		e icon: (e valueOfTokenNamed: arrowTk) value ]
]

{ #category : #'event handling' }
ToAccordionItemHeaderElementSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		arrowTk := #'submenu-arrow-up'.
		e icon: (e valueOfTokenNamed: arrowTk) value ]
]
