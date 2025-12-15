Class {
	#name : #ToTreeNodeSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'event handling' }
ToTreeNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToTreeNodeSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]
