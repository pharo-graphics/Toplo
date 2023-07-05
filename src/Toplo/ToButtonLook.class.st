Class {
	#name : #ToButtonLook,
	#superclass : #ToElementLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #testing }
ToButtonLook >> hasBackground [ 

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToButtonLook >> hoverStateEvent: anEvent [


]

{ #category : #testing }
ToButtonLook >> ifBackgoundUpdated: aBlock [

	self isBackgoundUpdater ifFalse: [ ^ self ].
	aBlock value
]

{ #category : #'event handling' }
ToButtonLook >> initialStateEvent: anEvent [


]

{ #category : #'event handling' }
ToButtonLook >> installStateEvent: anEvent [


]

{ #category : #testing }
ToButtonLook >> isBackgoundUpdater [

	^ self first hasBackground 
]

{ #category : #'event handling' }
ToButtonLook >> pressedStateEvent: anEvent [


]
