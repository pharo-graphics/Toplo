Class {
	#name : #ToTabItemElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabItemElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ] ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text-disabled') ] ] ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ] ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.

	anEvent elementDo: [ :e |
		e focusability: BlFocusability ignore.
		e border: BlBorder empty.
		e background: BlBackground transparent.
		(e hasStartElement and: [ e hasMiddleElement ])
			ifTrue: [
			e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e startInterspace: 0 ].
		(e hasEndElement and: [ e hasMiddleElement ])
			ifTrue: [
			e endInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e endInterspace: 0 ] ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| foreground |
		foreground := anEvent focused
			              ifTrue: [
			              e valueOfTokenNamed: #'selected-focused-foreground' ]
			              ifFalse: [
			              e valueOfTokenNamed: #'selected-unfocused-foreground' ].
		e iconDo: [ :ic |
			ic adaptToColor: foreground ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: foreground ] ] ]
]
