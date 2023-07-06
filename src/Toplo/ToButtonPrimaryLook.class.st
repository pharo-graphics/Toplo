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
ToButtonPrimaryLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorPrimaryHover ] ]
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (self decoratedBorderBuilderFromElement: e) build.
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorPrimary ] ]
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (self decoratedBorderBuilderFromElement: e) build.
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorPrimary ] ]
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorPrimaryPressed ] ]
]
