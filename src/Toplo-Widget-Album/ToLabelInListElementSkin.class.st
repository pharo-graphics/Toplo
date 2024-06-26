Class {
	#name : #ToLabelInListElementSkin,
	#superclass : #ToLabelSkin,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelInListElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder foreground:
			(e valueOfTokenNamed: #'label-in-list-foreground-deselected').
		e applyAttributesBuilder ]
]

{ #category : #'event handling' }
ToLabelInListElementSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| tokname |
		tokname := anEvent focused
			           ifTrue: [ #'label-in-list-foreground-selected-focused' ]
			           ifFalse: [
			           #'label-in-list-foreground-selected-unfocused' ].
		e textAttributesBuilder foreground: (e valueOfTokenNamed: tokname).
		e applyAttributesBuilder ]
]
