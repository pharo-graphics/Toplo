Class {
	#name : #ToTabBarSelectionElementSkin,
	#superclass : #ToListPrimarySelectionElementSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabBarSelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e listElement isWrapping ifFalse: [
			e geometry: BlRectangleGeometry new ] ]
]
