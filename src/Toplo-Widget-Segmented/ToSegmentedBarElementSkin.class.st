Class {
	#name : #ToSegmentedBarElementSkin,
	#superclass : #ToBarElementSkin,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'event handling' }
ToSegmentedBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent.
		e selectionMode option animationDuration: 200 milliSeconds ]
]
