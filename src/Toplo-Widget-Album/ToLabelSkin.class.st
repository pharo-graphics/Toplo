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
		e foreground: (e valueOfTokenNamed: #'color-text-disabled') ]
]

{ #category : #'event handling' }
ToLabelSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e foreground: (e valueOfTokenNamed: #'color-text') ]
]

{ #category : #'event handling' }
ToLabelSkin >> installSkinEvent: anEvent [
			
	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e textAttributesBuilder
			defaultFontSize: (e valueOfTokenNamed: #'font-size');
			lineSpacing: (e valueOfTokenNamed: #'line-height');
			foreground: (e valueOfTokenNamed: #'color-text').
		e editorBuilder: [ :ed :lab |
			ed text foreground: (lab valueOfTokenNamed: #'color-text') ].
		e applyStyle.
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-VS')
				 left: (e valueOfTokenNamed: #'padding-XS')
				 bottom: (e valueOfTokenNamed: #'padding-content-VS')
				 right: (e valueOfTokenNamed: #'padding-XS')) ]
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
