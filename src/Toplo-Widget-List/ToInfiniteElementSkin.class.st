Class {
	#name : #ToInfiniteElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'event handling' }
ToInfiniteElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e tokenValueNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToInfiniteElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e outskirts: BlOutskirts outside.
		e border: (e tokenValueNamed: #'color-border').
		e padding: (BlInsets
				 horizontal: (e tokenValueNamed: #'list-infinite-padding-H')
				 vertical: (e tokenValueNamed: #'list-infinite-padding-V')) ]
]

{ #category : #'event handling' }
ToInfiniteElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e tokenValueNamed: #'color-border') ]
]
