Class {
	#name : #ToBadgeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Float'
}

{ #category : #'event handling' }
ToBadgeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e extent: (e valueOfTokenNamed: #'badge-size') ]
]
