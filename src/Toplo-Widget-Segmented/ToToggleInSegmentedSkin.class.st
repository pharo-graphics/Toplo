Class {
	#name : #ToToggleInSegmentedSkin,
	#superclass : #ToBasicSkin,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'event handling' }
ToToggleInSegmentedSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToToggleInSegmentedSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToToggleInSegmentedSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToToggleInSegmentedSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e layout alignCenter.
		e border: BlBorder empty.
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-V')
				 left: (e valueOfTokenNamed: #'padding-XS')
				 bottom: (e valueOfTokenNamed: #'padding-content-V')
				 right: (e valueOfTokenNamed: #'padding-XS')).
		(e hasIcon and: [ e hasLabel ])
			ifTrue: [ e startInterspace: 10 ]
			ifFalse: [ e startInterspace: 0 ].
		(e hasEndElement and: [ e hasLabel ])
			ifTrue: [ e endInterspace: 10 ]
			ifFalse: [ e endInterspace: 0 ] ]
]

{ #category : #'event handling' }
ToToggleInSegmentedSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
