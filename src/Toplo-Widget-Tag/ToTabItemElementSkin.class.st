Class {
	#name : #ToTabItemElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabItemElementSkin >> configureSelectionTokensIn: anItemElement [

	anItemElement holder listElement isWrapping
		ifTrue: [
			anItemElement removeTokenNamed: #'selected-focused-foreground'.
			anItemElement removeTokenNamed: #'selected-unfocused-foreground' ]
		ifFalse: [
			anItemElement
				addTokenNamed: #'selected-focused-foreground'
				withValue:
				(anItemElement valueOfTokenNamed:
					 #'color-primary-selection-focused').
			anItemElement
				addTokenNamed: #'selected-unfocused-foreground'
				withValue:
				(anItemElement valueOfTokenNamed:
					 #'color-primary-selection-focused') ]
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
		self configureSelectionTokensIn: e.
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
		| leftPadding |
		leftPadding := e valueOfTokenNamed: #'padding-XS'.
		e isRemovable ifTrue: [
			leftPadding := leftPadding + e removeButton measuredWidth].
		e focusability: BlFocusability ignore.
		e border: BlBorder empty.
		e background: BlBackground transparent.
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-VXS')
				 left: leftPadding
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
