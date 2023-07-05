Class {
	#name : #ToButtonLinkLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #private }
ToButtonLinkLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  width: 0;
		  yourself
]

{ #category : #testing }
ToButtonLinkLook >> hasBackground [

	^ false
]
