Class {
	#name : #ToInfiniteElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'event handling' }
ToInfiniteElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToInfiniteElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e outskirts: BlOutskirts outside.
		e border: (e valueOfTokenNamed: #'color-border').
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'list-infinite-padding-H')
				 vertical: (e valueOfTokenNamed: #'list-infinite-padding-V')) ]
]

{ #category : #'event handling' }
ToInfiniteElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-border') ]
]
