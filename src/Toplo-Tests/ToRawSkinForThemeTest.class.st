Class {
	#name : #ToRawSkinForThemeTest,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #'event handling' }
ToRawSkinForThemeTest >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToRawSkinForThemeTest >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent ]
]
