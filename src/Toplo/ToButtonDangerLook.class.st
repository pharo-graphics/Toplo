Class {
	#name : #ToButtonDangerLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #private }
ToButtonDangerLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  paint: anElement toTheme colorError darker;
		  yourself
]

{ #category : #'event handling' }
ToButtonDangerLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorErrorHover ].
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorErrorHover;
				 build) ]
]

{ #category : #'event handling' }
ToButtonDangerLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorError ].
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorError;
				 build) ]
]

{ #category : #'event handling' }
ToButtonDangerLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorError ].
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorError;
				 build) ]
]

{ #category : #'event handling' }
ToButtonDangerLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorError darker ].
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorError darker;
				 build) ]
]
