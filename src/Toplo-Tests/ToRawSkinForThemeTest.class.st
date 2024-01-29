Class {
	#name : #ToRawSkinForThemeTest,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #'event handling' }
ToRawSkinForThemeTest >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToRawSkinForThemeTest >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent ]
]
