Class {
	#name : #ToButtonDashedLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Widget-Button-Look'
}

{ #category : #'event handling' }
ToButtonDashedLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  dashArray: anElement toTheme dashed;
		  yourself
]
