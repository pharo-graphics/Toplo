Class {
	#name : #ToBackgroundLook,
	#superclass : #ToElementLook,
	#instVars : [
		'initialBg',
		'hoverBg',
		'pressedBg'
	],
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #accessing }
ToBackgroundLook >> hoverBg [

	^ hoverBg
]

{ #category : #accessing }
ToBackgroundLook >> hoverBg: aBackground [

	hoverBg := aBackground
]

{ #category : #accessing }
ToBackgroundLook >> initialBg [

	^ initialBg
]

{ #category : #accessing }
ToBackgroundLook >> initialBg: anObject [

	initialBg := anObject
]

{ #category : #'event handling' }
ToBackgroundLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self initialBg ifNotNil: [ :bg | e background: bg ] ]
]

{ #category : #'event handling' }
ToBackgroundLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self hoverBg ifNotNil: [ :bg | e background: bg ] ]
]

{ #category : #'event handling' }
ToBackgroundLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self pressedBg ifNotNil: [ :bg | e background: bg ] ]
]

{ #category : #accessing }
ToBackgroundLook >> pressedBg [

	^ pressedBg
]

{ #category : #accessing }
ToBackgroundLook >> pressedBg: aBackground [

	pressedBg := aBackground
]
