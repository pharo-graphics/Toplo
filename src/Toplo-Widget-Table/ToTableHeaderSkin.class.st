Class {
	#name : #ToTableHeaderSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'event handling' }
ToTableHeaderSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :header |
			header padding: (BlInsets
					 horizontal: (header valueOfTokenNamed: #'list-padding-H')
					 vertical: (header valueOfTokenNamed: #'list-padding-V')) ]
]
