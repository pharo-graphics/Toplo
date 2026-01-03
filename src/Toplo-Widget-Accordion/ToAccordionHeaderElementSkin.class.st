Class {
	#name : #ToAccordionHeaderElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e | self expandHeader: e ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> collapseHeader: anHeader [

	anHeader icon beRight
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e | self collapseHeader: e ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> expandHeader: anHeader [

	anHeader icon beDown
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| arrowIm |
			e padding: (BlInsets
					 horizontal: (e valueOfTokenNamed: #'padding-content-HS')
					 vertical: (e valueOfTokenNamed: #'padding-content-V')).
			e geometry: (BlRoundedRectangleGeometry cornerRadius:
					 (e valueOfTokenNamed: 'border-radius')).
			arrowIm := e isExpanded
				           ifTrue: [ ToIconicArrowButton down ]
				           ifFalse: [ ToIconicArrowButton right ].
			arrowIm extent:
				(e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint.
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
