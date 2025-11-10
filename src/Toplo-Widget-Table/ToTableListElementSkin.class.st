Class {
	#name : #ToTableListElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'event handling' }
ToTableListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e geometry: BlRectangleGeometry new ]
]
