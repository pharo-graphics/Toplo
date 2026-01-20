Class {
	#name : #ToPlaceholderLayerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #'event handling' }
ToPlaceholderLayerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e
				addTokenNamed: #'color-text'
				withValue: (e valueOfTokenNamed: #'color-text-placeholder') ]
]

{ #category : #'event handling' }
ToPlaceholderLayerSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e removeTokenNamed: #'color-text' ]
]
