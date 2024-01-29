Class {
	#name : #ToListElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToListElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-border').
		e background: (e valueOfTokenNamed: #'color-bg-container').
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'list-padding-H')
				 vertical: (e valueOfTokenNamed: #'list-padding-V')) ]
]
