Class {
	#name : #ToSegmentedNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Segmented-Node'
}

{ #category : #'event handling' }
ToSegmentedNodeSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e |
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToSegmentedNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent.
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'segmented-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'segmented-node-padding-V')).
		e border: (BlBorder empty) ]
]

{ #category : #'event handling' }
ToSegmentedNodeSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
