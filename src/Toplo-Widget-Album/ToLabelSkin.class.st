Class {
	#name : #ToLabelSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e |
		| to |
		"e text asString trace. ' ' trace. anEvent traceCr."
		to := e valueOfTokenNamed: #'color-text'.
		e foreground: to ]
]

{ #category : #'event handling' }
ToLabelSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e text asString trace. ' ' trace. anEvent traceCr."
		e foreground: (e valueOfTokenNamed: #'color-text-disabled').
		e applyStyle ]
]

{ #category : #'event handling' }
ToLabelSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e text asString trace. ' ' trace. anEvent traceCr."
		e foreground: (e valueOfTokenNamed: #'color-text').
		e applyStyle ]
]

{ #category : #'event handling' }
ToLabelSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e text asString trace. ' ' trace. anEvent traceCr."
		e textAttributesBuilder
			defaultFontSize: (e valueOfTokenNamed: #'font-size');
			lineSpacing: (e valueOfTokenNamed: #'line-height');
			foreground: (e valueOfTokenNamed: #'color-text').
		e applyStyle ]
]

{ #category : #'event handling' }
ToLabelSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e |
		| foreground |
		"e text asString trace. ' ' trace. anEvent traceCr."
		anEvent focused
			ifTrue: [
				e
					withStamp: #'label-selected-focused-foreground'
					do: [ :v | foreground := v ]
					ifNone: [
					foreground := e valueOfTokenNamed: #'label-selected-focused' ] ]
			ifFalse: [
				e
					withStamp: #'label-selected-unfocused-foreground'
					do: [ :v | foreground := v ]
					ifNone: [
					foreground := e valueOfTokenNamed: #'label-selected-unfocused' ] ].
		e foreground: foreground.
		e applyStyle ]
]
