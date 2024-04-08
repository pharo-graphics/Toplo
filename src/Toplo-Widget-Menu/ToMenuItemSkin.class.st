Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToGeneralButtonMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuItemSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e valueOfTokenNamed: #'color-text-disabled')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e valueOfTokenNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-primary') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e valueOfTokenNamed: #'color-primary')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e labeledIcon hMatchParent.
		e isTopMenu ifFalse: [
			e parentMenuDo: [ :pm |
				(pm items anySatisfy: [ :mi | mi hasIcon ]) ifTrue: [
					e button startAlignment:
						(e valueOfTokenNamed: #'menu-item-start-alignment') ] ] ].
		e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |	
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e valueOfTokenNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e | 	
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-primary-pressed') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e valueOfTokenNamed: #'color-primary-pressed')) }.
			lab textChanged ] ]
]
