Class {
	#name : #ToTableElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #'event handling' }
ToTableElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e padding: (BlInsets
					 horizontal: (e valueOfTokenNamed: #'list-padding-H')
					 vertical: (e valueOfTokenNamed: #'list-padding-V')) ]
]
