Class {
	#name : #ToButtonLookDecorator,
	#superclass : #ToButtonLook,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #testing }
ToButtonLookDecorator >> hasBackground [

	^ self next hasBackground
]
