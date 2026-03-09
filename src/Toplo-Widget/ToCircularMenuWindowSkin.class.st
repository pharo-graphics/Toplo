Class {
	#name : #ToCircularMenuWindowSkin,
	#superclass : #ToBasicWindowElementSkin,
	#category : #'Toplo-Widget-Circular'
}

{ #category : #'event handling' }
ToCircularMenuWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e border: BlBorder empty.
			e padding: BlInsets empty.
			e geometry: BlCircleGeometry new ]
]
