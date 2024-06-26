Class {
	#name : #ToButtonSkin,
	#superclass : #ToGeneralButtonSkin,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'event handling' }
ToButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text-disabled')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes:
				{ (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-primary') ].
		e endElementDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-primary') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-primary')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e hasIcon and: [ e hasLabel ])
			ifTrue: [ e startInterspace: 10 ]
			ifFalse: [ e startInterspace: 0 ].
		(e hasEndElement and: [ e hasLabel ])
			ifTrue: [ e endInterspace: 10 ]
			ifFalse: [ e endInterspace: 0 ].
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes:
				{ (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text')) }.
			lab textChanged ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic | ic formColor: (e valueOfTokenNamed: #'color-text') ].
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
		e endElementDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-primary-pressed') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-primary-pressed')) }.
			lab textChanged ] ]
]
