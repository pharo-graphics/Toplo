Class {
	#name : #ToListInfiniteElementSkin,
	#superclass : #ToRawSkin,
	#category : 'Toplo-Widget-List-Infinite'
}

{ #category : #'event handling' }
ToListInfiniteElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e tokenValueNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToListInfiniteElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e outskirts: BlOutskirts outside.
		e border: (e tokenValueNamed: #'color-border').
		e padding: (BlInsets
				 horizontal: (e tokenValueNamed: #'list-infinite-padding-H')
				 vertical: (e tokenValueNamed: #'list-infinite-padding-V')) ]
]

{ #category : #'event handling' }
ToListInfiniteElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e tokenValueNamed: #'color-border') ]
]
