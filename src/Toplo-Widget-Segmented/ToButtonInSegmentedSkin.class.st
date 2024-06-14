Class {
	#name : #ToButtonInSegmentedSkin,
	#superclass : #ToGeneralButtonInSegmentedSkin,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'event handling' }
ToButtonInSegmentedSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
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
ToButtonInSegmentedSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
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
ToButtonInSegmentedSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
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
ToButtonInSegmentedSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
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
ToButtonInSegmentedSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
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
ToButtonInSegmentedSkin >> pressedLookEvent: anEvent [

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
