Class {
	#name : #ToTableNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'event handling' }
ToTableNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'list-node-padding-H') 
				 vertical: (e valueOfTokenNamed: #'list-node-padding-V'))" ]
]
