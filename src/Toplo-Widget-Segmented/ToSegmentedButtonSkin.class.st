Class {
	#name : #ToSegmentedButtonSkin,
	#superclass : #ToBasicSkin,
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #'event handling' }
ToSegmentedButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToSegmentedButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e focusability: BlFocusability ignore.
		e layout alignCenter.
		e border: BlBorder empty.
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-VXS')
				 left: (e valueOfTokenNamed: #'padding-XS')
				 bottom: (e valueOfTokenNamed: #'padding-content-VXS')
				 right: (e valueOfTokenNamed: #'padding-XS')).
		(e hasIcon and: [ e hasLabel ])
			ifTrue: [ e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e startInterspace: 0 ].
		(e hasEndElement and: [ e hasLabel ])
			ifTrue: [ e endInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e endInterspace: 0 ] ]
]

{ #category : #'event handling' }
ToSegmentedButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
