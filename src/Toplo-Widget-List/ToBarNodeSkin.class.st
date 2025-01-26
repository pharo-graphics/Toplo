Class {
	#name : #ToBarNodeSkin,
	#superclass : #ToBasicNodeSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToBarNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent.
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'bar-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'bar-node-padding-V')) ]
]
