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

{ #category : #'event handling' }
ToBackgroundLook >> clickLookEvent: anEvent [ 

	super clickLookEvent: anEvent .
	anEvent elementDo: [ :e |
		self hoverBg ifNotNil: [ :bg | e background: (bg value: e)] ]
]

{ #category : #accessing }
ToBackgroundLook >> hoverBg [

	^ hoverBg
]

{ #category : #accessing }
ToBackgroundLook >> hoverBg: aValuable [

	hoverBg := aValuable
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
ToBackgroundLook >> initialBg: aValuable [

	initialBg := aValuable
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
ToBackgroundLook >> pressedBg: aValuable [

	pressedBg := aValuable
]

{ #category : #'event handling' }
ToBackgroundLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self pressedBg ifNotNil: [ :bg | e background: (bg value: e)] ]
]
