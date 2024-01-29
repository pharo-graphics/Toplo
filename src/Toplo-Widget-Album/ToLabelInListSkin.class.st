Class {
	#name : #ToLabelInListSkin,
	#superclass : #ToLabelSkin,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelInListSkin >> deselectedLookEvent: anEvent [

	super deselectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder foreground: (e valueOfTokenNamed: #'label-in-list-foreground-deselected').
		e applyAttributesBuilder.
		e textChanged ]
]

{ #category : #'event handling' }
ToLabelInListSkin >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| tokname |
		tokname := anEvent focused
			           ifTrue: [ #'label-in-list-foreground-selected-focused' ]
			           ifFalse: [ #'label-in-list-foreground-selected-unfocused' ].
		e textAttributesBuilder foreground: (e valueOfTokenNamed: tokname).
		e applyAttributesBuilder.
		e textChanged ]
]
