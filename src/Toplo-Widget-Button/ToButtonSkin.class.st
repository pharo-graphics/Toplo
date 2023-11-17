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
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: Color lightGray) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: Color black) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: Color blue) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e | e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: Color black) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |	
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: Color black) }.
			lab textChanged ] ]
]

{ #category : 'event handling' }
ToButtonSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e | 	
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint: Color blue darker) }.
			lab textChanged ] ]
]
