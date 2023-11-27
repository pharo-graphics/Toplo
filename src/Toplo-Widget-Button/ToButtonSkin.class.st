Class {
	#name : 'ToButtonSkin',
	#superclass : 'ToGeneralButtonSkin',
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 'event handling' }
ToButtonSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e toValueOf: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e toValueOf: #'color-text-disabled')) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e toValueOf: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e toValueOf: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e toValueOf: #'color-primary') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e toValueOf: #'color-primary')) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e iconDo: [ :ic | ic formColor: (e toValueOf: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e toValueOf: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |	
		e iconDo: [ :ic | ic formColor: (e toValueOf: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e toValueOf: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e | 	
		e iconDo: [ :ic | ic formColor: (e toValueOf: #'color-primary-pressed') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: (e toValueOf: #'color-primary-pressed')) }.
			lab textChanged ] ]
]
