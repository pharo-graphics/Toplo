Class {
	#name : #ToBasicNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToBasicNodeSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToBasicNodeSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]
