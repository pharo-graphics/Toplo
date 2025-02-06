Class {
	#name : #ToAccordionHeaderElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e | self expandHeader: e ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> collapseHeader: anHeader [

	| arrowTk |
	arrowTk := #'submenu-arrow-up'.
	anHeader icon: (anHeader valueOfTokenNamed: arrowTk) value.
	anHeader background: Color transparent
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e | self collapseHeader: e ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> expandHeader: anHeader [

	| arrowTk |
	arrowTk := #'submenu-arrow-down'.
	anHeader icon: (anHeader valueOfTokenNamed: arrowTk) value.
	anHeader background:
		(anHeader valueOfTokenNamed: #'color-secondary-selection')
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		arrowTk := e isExpanded
			           ifTrue: [ #'submenu-arrow-down' ]
			           ifFalse: [ #'submenu-arrow-up' ].
		e icon: (e valueOfTokenNamed: arrowTk) value.
		e background: Color transparent ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e | self expandHeader: e ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e | self collapseHeader: e ]
]
