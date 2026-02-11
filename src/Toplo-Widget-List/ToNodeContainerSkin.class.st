Class {
	#name : #ToNodeContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToNodeContainerSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e removeTokenNamed: #'checkbox-color' ]
]

{ #category : #'event handling' }
ToNodeContainerSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| f |
			f := e holder listElement isFocused
				     ifTrue: [
				     e valueOfTokenNamed: #'selected-focused-foreground' ]
				     ifFalse: [
				     e valueOfTokenNamed: #'selected-unfocused-foreground' ].
			e addTokenNamed: #'checkbox-color' withValue: f ].
]
