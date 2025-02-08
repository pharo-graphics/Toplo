Class {
	#name : #ToEmptySkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Empty'
}

{ #category : #'event handling' }
ToEmptySkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e layout alignCenter.
		(e hasStamp: #box) ifTrue: [
			e installInnerImage: (e valueOfTokenNamed: #empty_box) value ] ]
]
