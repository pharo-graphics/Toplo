Class {
	#name : #ToLabelSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| to |
		to := e valueOfTokenNamed: #'color-text'.
		e foreground: to ]
]

{ #category : #'event handling' }
ToLabelSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e foreground: (e valueOfTokenNamed: #'color-text-disabled').
		e applyStyle ]
]

{ #category : #'event handling' }
ToLabelSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e foreground: (e valueOfTokenNamed: #'color-text').
		e applyStyle ]
]

{ #category : #'event handling' }
ToLabelSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder
			defaultFontSize: (e valueOfTokenNamed: #'font-size');
			lineSpacing: (e valueOfTokenNamed: #'line-height');
			foreground: (e valueOfTokenNamed: #'color-text').
		e editorBuilder: [ :ed :lab |
			ed text foreground: (lab valueOfTokenNamed: #'color-text') ].
		e applyStyle.
		(e hasAnyInParentChainSatisfying: [ :p | p isMenuItem ])
			ifFalse: [
				e padding: (BlInsets
						 horizontal: (e valueOfTokenNamed: #'padding-content-H')
						 vertical: (e valueOfTokenNamed: #'padding-content-VXS')) ] ]
]

{ #category : #'event handling' }
ToLabelSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| tokname to |
		tokname := anEvent focused
			           ifTrue: [ #'label-selected-focused' ]
			           ifFalse: [ #'label-selected-unfocused' ].
		to := e valueOfTokenNamed: tokname.
		e foreground: to.
		e applyStyle ]
]
