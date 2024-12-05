Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToGeneralButtonMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuItemSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ]" ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ]" ]
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
		e isTopMenu ifFalse: [
			e isStartToEnd
				ifTrue: [
					e endInterspace: (e valueOfTokenNamed: #'button-interspace').
					e endFlexible: true ]
				ifFalse: [
					e startInterspace: (e valueOfTokenNamed: #'button-interspace').
					e startFlexible: true ] ] ]
]
