Class {
	#name : #ToRadioImageSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToRadioImageSkin >> whenAddedToSpace: anEvent in: anElement [ 

	| borderLook |
		
	anElement geometry: (BlCircleGeometry new).
	borderLook := ToBorderLook new
				initialPaint: anElement toTheme colorBorder;
				hoverPaint: anElement toTheme colorPrimaryHover;
				pressedPaint: anElement toTheme colorPrimaryPressed;
				width: 1.
	self addLook: borderLook.

	super whenAddedToSpace: anEvent in: anElement.

]
