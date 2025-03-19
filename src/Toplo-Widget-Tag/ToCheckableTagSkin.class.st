Class {
	#name : #ToCheckableTagSkin,
	#superclass : #ToTagElementSkin,
	#category : #'Toplo-Widget-Tag-Core'
}

{ #category : #'event handling' }
ToCheckableTagSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToCheckableTagSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e mouseCursor: Cursor normal ]
]
