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
ToSegmentedButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
