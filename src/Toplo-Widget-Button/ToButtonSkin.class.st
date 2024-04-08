Class {
	#name : #ToButtonSkin,
	#superclass : #ToGeneralButtonSkin,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'event handling' }
ToButtonSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endIconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text-disabled')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e endIconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes:
				{ (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-primary') ].
		e endIconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-primary') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-primary')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		(e hasIcon and: [ e hasLabel ])
			ifTrue: [ e interspace: 10 ]
			ifFalse: [ e interspace: 0 ].
		(e hasEndIcon and: [ e hasLabel ])
			ifTrue: [ e endInterspace: 10 ]
			ifFalse: [ e endInterspace: 0 ].
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e endIconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes:
				{ (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e endIconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes:
				{ (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-primary-pressed') ].
		e endIconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-primary-pressed') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-primary-pressed')) }.
			lab textChanged ] ]
]
