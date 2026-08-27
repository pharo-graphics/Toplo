Class {
	#name : #ToTextFieldPlaceholderSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #'event handling' }
ToTextFieldPlaceholderSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | "This is a hack? because we need to style the sub text
		Maybe there are missing API for text placeholder"
		e children do: [ :child | child textAttributesBuilder foreground: (e valueOfTokenNamed: #'color-text-placeholder') ] ]
]

{ #category : #'event handling' }
ToTextFieldPlaceholderSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e removeTokenNamed: #'color-text' ]
]
