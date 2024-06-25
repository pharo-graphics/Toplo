Class {
	#name : #ToListNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToListNodeSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'list-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'list-node-padding-V')) ]
]
