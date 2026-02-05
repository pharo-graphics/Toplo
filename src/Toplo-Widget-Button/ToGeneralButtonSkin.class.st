Class {
	#name : #ToGeneralButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Button-Clickable'
}

{ #category : #'event handling' }
ToGeneralButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e isMenuButton ifFalse: [
			(e hasStamp: #borderless) ifFalse: [
				e border: (BlBorder
						 paint: (e valueOfTokenNamed: #'color-border-disabled')
						 width: (e valueOfTokenNamed: #'line-width')) ].
			e background: (e valueOfTokenNamed: #'color-bg-container-disabled') ] ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isMenuButton ifFalse: [
			(e hasStamp: #borderless) ifFalse: [
				e border: (BlBorder
						 paint: (e valueOfTokenNamed: #'color-border')
						 width: (e valueOfTokenNamed: #'line-width')) ].
			(e hasStamp: #iconic) ifFalse: [
				e background: (e valueOfTokenNamed: #'color-bg-container') ] ] ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink.
		e isMenuButton ifFalse: [
			(e hasStamp: #borderless) ifFalse: [
				e border: (BlBorder
						 paint: (e valueOfTokenNamed: #'color-primary-hover')
						 width: (e valueOfTokenNamed: #'line-width')) ] ] ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		(e hasStamp: #circle)
			ifTrue: [ e geometry: BlCircleGeometry new ]
			ifFalse: [
				e geometry: BlStadiumGeometry new ].
		(e hasStamp: #iconic) ifFalse: [
				e padding: (BlInsets
						 horizontal: (e valueOfTokenNamed: #'padding-XS')
						 vertical: (e valueOfTokenNamed: #'padding-content-VS')) ] ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e isEnabled ifTrue: [
			e isMenuButton ifFalse: [
				(e hasStamp: #borderless) ifFalse: [
					e border: (BlBorder
							 paint: (e valueOfTokenNamed: #'color-border')
							 width: (e valueOfTokenNamed: #'line-width')) ] ] ] ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e isEnabled ifTrue: [
			e isMenuButton ifFalse: [
				(e hasStamp: #borderless) ifFalse: [
					e border: (BlBorder
							 paint: (e valueOfTokenNamed: #'color-border')
							 width: (e valueOfTokenNamed: #'line-width')) ] ] ] ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isMenuButton ifFalse: [
			(e hasStamp: #borderless) ifFalse: [
				e border: (BlBorder
						 paint: (e valueOfTokenNamed: #'color-primary-pressed')
						 width: (e valueOfTokenNamed: #'line-width')) ] ] ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> releasedSkinEvent: anEvent [

	super releasedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e isMenuButton ifFalse: [
					(e hasStamp: #borderless) ifFalse: [
							e border: (BlBorder
									 paint: (e valueOfTokenNamed: #'color-primary-hover')
									 width: (e valueOfTokenNamed: #'line-width')) ] ] ]
]
