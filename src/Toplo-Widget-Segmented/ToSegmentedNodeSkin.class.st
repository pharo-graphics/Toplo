Class {
	#name : #ToSegmentedNodeSkin,
	#superclass : #ToCheckableNodeSkin,
	#category : #'Toplo-Widget-Segmented-Node'
}

{ #category : #'event handling' }
ToSegmentedNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'segmented-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'segmented-node-padding-V')) ]
]
