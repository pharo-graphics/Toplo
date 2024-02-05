Class {
	#name : #ToListElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToListElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToListElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-border').
		e background: (e valueOfTokenNamed: #'color-bg-container').
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'list-padding-H')
				 vertical: (e valueOfTokenNamed: #'list-padding-V')).
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e margin: BlInsets empty.
		e outskirts: BlOutskirts inside ]
]

{ #category : #'event handling' }
ToListElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-border') ]
]
