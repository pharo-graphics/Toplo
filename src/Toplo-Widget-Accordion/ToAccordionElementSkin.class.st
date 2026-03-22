Class {
	#name : #ToAccordionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #'event handling' }
ToAccordionElementSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e | self expandHeader: e header ]
]

{ #category : #'event handling' }
ToAccordionElementSkin >> collapseHeader: anHeader [

	anHeader icon beRight
]

{ #category : #'event handling' }
ToAccordionElementSkin >> expandHeader: anHeader [

	anHeader icon beDown
]

{ #category : #'event handling' }
ToAccordionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| arrowIm |
			(e hasStamp: #borderless)
				ifTrue: [ e border: BlBorder empty ]
				ifFalse: [ e border: (e valueOfTokenNamed: #'border-paint') ].
			e geometry: (BlRoundedRectangleGeometry cornerRadius:
					 (e valueOfTokenNamed: 'border-radius')).
			arrowIm := e isExpanded
				           ifTrue: [ ToIconicArrowButton down ]
				           ifFalse: [ ToIconicArrowButton right ].
			arrowIm extent:
				(e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint.
			e header icon: arrowIm ]
]

{ #category : #'event handling' }
ToAccordionElementSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e | self collapseHeader: e header ]
]
