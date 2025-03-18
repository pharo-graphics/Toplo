Class {
	#name : #ToTabItemElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabItemElementSkin >> configureLabelInItemElement: anItemElement [

	anItemElement labelDo: [ :label |
		anItemElement holder listElement isWrapping
			ifTrue: [ label removeStamp: #'label-selected-focused-foreground' ]
			ifFalse: [
				label
					addStamp: #'label-selected-focused-foreground'
					withValue:
					(anItemElement valueOfTokenNamed:
						 #'color-primary-selection-focused') ] ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.

	anEvent elementDo: [ :e |
		self configureLabelInItemElement: e ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ] ] ]
]

{ #category : #'event handling' }
ToTabItemElementSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		self configureLabelInItemElement: e.
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text') ] ] ]
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
		self configureLabelInItemElement: e.
		e focusability: BlFocusability ignore.
		e border: BlBorder empty.
		e background: BlBackground transparent.
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-VXS')
				 left: (e valueOfTokenNamed: #'padding-XS')
				 bottom: (e valueOfTokenNamed: #'padding-content-VXS')
				 right: (e valueOfTokenNamed: #'padding-XS')).
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
ToTabItemElementSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.

	anEvent elementDo: [ :e |
		self configureLabelInItemElement: e ]
]
