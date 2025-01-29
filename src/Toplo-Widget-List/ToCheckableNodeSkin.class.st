Class {
	#name : #ToCheckableNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'as yet unclassified' }
ToCheckableNodeSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e |
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToCheckableNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent.
		e border: (BlBorder empty) ]
]

{ #category : #'as yet unclassified' }
ToCheckableNodeSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
