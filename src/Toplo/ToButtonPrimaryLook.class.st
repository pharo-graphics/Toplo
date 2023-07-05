Class {
	#name : #ToButtonPrimaryLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #private }
ToButtonPrimaryLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  width: 0;
		  yourself
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> hoverStateEvent: anEvent [

	super hoverStateEvent: anEvent.
	anEvent elementDo: [ :e |
		e privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorPrimaryHover ] ]
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> initialStateEvent: anEvent [

	super initialStateEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (self decoratedBorderBuilderFromElement: e) build.
		e privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorPrimary ] ]
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> installStateEvent: anEvent [

	super installStateEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (self decoratedBorderBuilderFromElement: e) build.
		e privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorPrimary ] ]
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> pressedStateEvent: anEvent [

	super pressedStateEvent: anEvent.
	anEvent elementDo: [ :e |
		e privateSkin hasBackground ifTrue: [ 
			e background: e toTheme colorPrimaryPressed ] ]
]
