Class {
	#name : #ToItemNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'event handling' }
ToItemNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]
