Class {
	#name : #ToListElementSkin,
	#superclass : #ToRawSkin,
	#category : 'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToListElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e outskirts: BlOutskirts outside.
		e border: (e tokenValueNamed: #'color-border').
		e background: (e tokenValueNamed: #'color-bg-container').
		e padding: (BlInsets
				 horizontal: (e tokenValueNamed: #'list-padding-H')
				 vertical: (e tokenValueNamed: #'list-padding-V')) ]
]
