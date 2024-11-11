Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToGeneralButtonMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuItemSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-primary') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-primary') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isTopMenu ifFalse: [
			e hMatchParent.
			e parentMenuDo: [ :pm |
				(pm items anySatisfy: [ :mi | mi hasIcon ]) ifTrue: [
					e button startAlignment:
						(e valueOfTokenNamed: #'menu-item-start-alignment') ] ] ].
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-primary-pressed') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-primary-pressed') ] ]
]
