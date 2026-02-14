Class {
	#name : #ToCircularMenuWindowSkin,
	#superclass : #ToMenuWindowSkin,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'event handling' }
ToCircularMenuWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e padding: BlInsets empty.
			e geometry: BlCircleGeometry new ]
]
