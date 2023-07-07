Class {
	#name : #ToButtonDashedLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToButtonDashedLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  dashArray: anElement toTheme dashed;
		  yourself
]

{ #category : #'event handling' }
ToButtonDashedLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorBorder;
				 build) ]
]

{ #category : #'event handling' }
ToButtonDashedLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorBorder;
				 build) ]
]
