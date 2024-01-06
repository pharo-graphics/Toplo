Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToGeneralButtonMenuItemSkin,
	#category : 'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuItemSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e tokenValueNamed: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e tokenValueNamed: #'color-text-disabled')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e tokenValueNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e tokenValueNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e tokenValueNamed: #'color-primary') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e tokenValueNamed: #'color-primary')) }.
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
					e button rightLabelAlignment: 25 ] ] ].
		e iconDo: [ :ic | ic formColor: (e tokenValueNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes:
				{ (BlTextForegroundAttribute paint:
					 (e tokenValueNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |	
		e iconDo: [ :ic | ic formColor: (e tokenValueNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e tokenValueNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e | 	
		e iconDo: [ :ic | ic formColor: (e tokenValueNamed: #'color-primary-pressed') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e tokenValueNamed: #'color-primary-pressed')) }.
			lab textChanged ] ]
]
