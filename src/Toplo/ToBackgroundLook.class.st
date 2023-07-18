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

{ #category : #'event handling' }
ToBackgroundLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self hoverBg ifNotNil: [ :bg | e background: (bg value: e)] ]
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
		self initialBg ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #accessing }
ToBackgroundLook >> pressedBg [

	^ pressedBg
]

{ #category : #accessing }
ToBackgroundLook >> pressedBg: aBackground [

	pressedBg := aBackground
]

{ #category : #'event handling' }
ToBackgroundLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self pressedBg ifNotNil: [ :bg | e background: (bg value: e)] ]
]
