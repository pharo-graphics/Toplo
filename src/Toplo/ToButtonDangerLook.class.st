Class {
	#name : #ToButtonDangerLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #private }
ToButtonDangerLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  paint: anElement toTheme colorError darker;
		  yourself
]

{ #category : #'event handling' }
ToButtonDangerLook >> hoverStateEvent: anEvent [

	super hoverStateEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent target privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorErrorHover].
		e border: ((self decoratedBorderBuilderFromElement: e) paint: e toTheme colorErrorHover; build) ]
]

{ #category : #'event handling' }
ToButtonDangerLook >> initialStateEvent: anEvent [

	super initialStateEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent target privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorError].
		e border: ((self decoratedBorderBuilderFromElement: e) paint: e toTheme colorError; build) ]
]

{ #category : #'event handling' }
ToButtonDangerLook >> installStateEvent: anEvent [

	super installStateEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent target privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorError].
		e border: ((self decoratedBorderBuilderFromElement: e) paint: e toTheme colorError; build) ]
]

{ #category : #'event handling' }
ToButtonDangerLook >> pressedStateEvent: anEvent [

	super pressedStateEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent target privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorError darker].
		e border: ((self decoratedBorderBuilderFromElement: e) paint: e toTheme colorError darker; build) ]
]
