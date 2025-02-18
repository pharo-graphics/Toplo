Class {
	#name : #ToListNodeSkin,
	#superclass : #ToBasicNodeSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToListNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'list-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'list-node-padding-V')) ]
]
