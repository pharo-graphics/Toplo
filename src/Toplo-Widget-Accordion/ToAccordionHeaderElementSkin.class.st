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

	| arrowTk arrowIm |
	arrowTk := #'submenu-arrow-right'.
	arrowIm := anHeader valueOfTokenNamed: arrowTk.
	anHeader icon innerImage: arrowIm
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e | self collapseHeader: e ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> expandHeader: anHeader [

	| arrowTk arrowIm |
	arrowTk := #'submenu-arrow-down'.
	arrowIm := anHeader valueOfTokenNamed: arrowTk.
	anHeader icon innerImage: arrowIm
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| arrowTk arrowIm |
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'padding-content-HS')
				 vertical: (e valueOfTokenNamed: #'padding-content-V')).
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		arrowTk := e isExpanded
			           ifTrue: [ #'submenu-arrow-down' ]
			           ifFalse: [ #'submenu-arrow-right' ].
		arrowIm := ToImage inner: (e valueOfTokenNamed: arrowTk).
		arrowIm
			size: 18 asPoint;
			innerImageColor: (e valueOfTokenNamed: #'color-text').
		e icon: arrowIm.
		(e parent hasStamp: #ghost) ifFalse: [
			e background: (e valueOfTokenNamed: #'color-secondary-selection') ] ]
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
