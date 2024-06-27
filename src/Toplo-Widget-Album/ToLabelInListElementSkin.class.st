Class {
	#name : #ToLabelInListElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #testing }
ToLabelInListElementSkin class >> isDeprecated [ 

	^ true
]

{ #category : #'event handling' }
ToLabelInListElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder foreground:
			(e valueOfTokenNamed: #'label-foreground-deselected').
		e applyAttributesBuilder ]
]

{ #category : #'event handling' }
ToLabelInListElementSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder foreground:
			(e valueOfTokenNamed: #'color-text-disabled').
		e applyAttributesBuilder ]
]

{ #category : #'event handling' }
ToLabelInListElementSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder foreground:
			(e valueOfTokenNamed: #'color-text').
		e applyAttributesBuilder ]
]

{ #category : #'event handling' }
ToLabelInListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder 
			weight: (e valueOfTokenNamed: #'font-weight-strong');
			defaultFontName: (e valueOfTokenNamed: #'font-family-code');
			defaultFontSize: (e valueOfTokenNamed: #'font-size');
			lineSpacing: (e valueOfTokenNamed: #'line-height').
		e editorBuilder: [ :ed :lab | ed text foreground: (lab valueOfTokenNamed: #'color-text') ].
		e applyAttributesBuilder ]
]

{ #category : #'event handling' }
ToLabelInListElementSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| tokname |
		tokname := anEvent focused
			           ifTrue: [ #'label-selected-focused' ]
			           ifFalse: [ #'label-selected-unfocused' ].
		e textAttributesBuilder foreground: (e valueOfTokenNamed: tokname).
		e applyAttributesBuilder ]
]
