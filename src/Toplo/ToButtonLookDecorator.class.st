Class {
	#name : #ToButtonLookDecorator,
	#superclass : #ToButtonLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #testing }
ToButtonLookDecorator >> hasBackground [

	^ self next hasBackground
]
