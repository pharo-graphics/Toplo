Class {
	#name : #ToButtonLook,
	#superclass : #ToElementLook,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #'event handling' }
ToButtonLook >> hoverStateEvent: anEvent [

	self next ifNil: [ ^ self ].
	self next hoverStateEvent: anEvent
]

{ #category : #'event handling' }
ToButtonLook >> initialStateEvent: anEvent [

	self next ifNil: [ ^ self ].
	self next initialStateEvent: anEvent
]

{ #category : #'event handling' }
ToButtonLook >> pressedStateEvent: anEvent [

	self next ifNil: [ ^ self ].
	self next pressedStateEvent: anEvent
]
