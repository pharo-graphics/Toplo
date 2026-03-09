Class {
	#name : #ToMultiSelectHeaderListElementSkin,
	#superclass : #ToListElementSkin,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'event handling' }
ToMultiSelectHeaderListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: BlBorder empty ]
]
