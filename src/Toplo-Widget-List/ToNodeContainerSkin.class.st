Class {
	#name : #ToNodeContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToNodeContainerSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.

	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e |
			e holder listElement nodeManager checkableNode ifTrue: [
				e removeTokenNamed: #'checkbox-color' ] ]
]

{ #category : #'event handling' }
ToNodeContainerSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.

	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent elementDo: [ :e |
			e holder listElement nodeManager checkableNode ifTrue: [
					| f |
					f := anEvent focused
						     ifTrue: [
						     e valueOfTokenNamed: #'selected-focused-foreground' ]
						     ifFalse: [
						     e valueOfTokenNamed: #'selected-unfocused-foreground' ].
					e addTokenNamed: #'checkbox-color' withValue: f ] ]
]
