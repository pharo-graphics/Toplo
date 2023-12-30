Class {
	#name : #ToListLabelSkin,
	#superclass : #ToLabelSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToListLabelSkin >> deselectedLookEvent: anEvent [

	super deselectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder foreground: (e tokenValueNamed: #'color-text').
		e applyAttributesBuilder.
		e textChanged ]
]

{ #category : #'event handling' }
ToListLabelSkin >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| tokname |
		tokname := anEvent focused
			           ifTrue: [ #'color-text-list-selection-focused' ]
			           ifFalse: [ #'color-text-list-selection-unfocused' ].
		e textAttributesBuilder foreground: (e tokenValueNamed: tokname).
		e applyAttributesBuilder.
		e textChanged ]
]
