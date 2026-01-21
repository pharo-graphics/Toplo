Class {
	#name : #ToTabPaneHeaderElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #'event handling' }
ToTabPaneHeaderElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e geometry: BlRectangleGeometry new]
]
