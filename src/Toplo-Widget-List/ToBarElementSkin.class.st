Class {
	#name : #ToBarElementSkin,
	#superclass : #ToListElementSkin,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToBarElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToBarElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: BlInsets empty.
		e border: BlBorder empty.
		e margin: BlInsets empty.
		e outskirts: BlOutskirts inside ]
]

{ #category : #'event handling' }
ToBarElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]
