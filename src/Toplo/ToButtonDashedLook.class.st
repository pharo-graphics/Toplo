Class {
	#name : #ToButtonDashedLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #'event handling' }
ToButtonDashedLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  dashArray: anElement toTheme dashed;
		  yourself
]

{ #category : #testing }
ToButtonDashedLook >> hasBackground [

	^ false
]
