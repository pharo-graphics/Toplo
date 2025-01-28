Class {
	#name : #ToListEmbeddedNodeExampleSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'event handling' }
ToListEmbeddedNodeExampleSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e background: Color transparent ]
]

{ #category : #'event handling' }
ToListEmbeddedNodeExampleSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e background: Color lightGreen ]
]
