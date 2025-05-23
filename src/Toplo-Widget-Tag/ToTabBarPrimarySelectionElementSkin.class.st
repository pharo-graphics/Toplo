Class {
	#name : #ToTabBarPrimarySelectionElementSkin,
	#superclass : #ToListPrimarySelectionElementSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabBarPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e listElement isFlowable ifFalse: [
			e geometry: BlRectangleGeometry new.
			e visibility: e node visibility ] ]
]
