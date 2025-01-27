Class {
	#name : #ToSegmentedToggleButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #'event handling' }
ToSegmentedToggleButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ] ].
		e background: (e valueOfTokenNamed: #'color-bg-container-disabled').
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToSegmentedToggleButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text') ] ].
		e background: BlBackground transparent.
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToSegmentedToggleButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e |
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToSegmentedToggleButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e focusability: BlFocusability ignore.
		e layout alignCenter.
		e border: BlBorder empty.
		e background: BlBackground transparent.
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
ToSegmentedToggleButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
