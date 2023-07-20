Class {
	#name : #ToCheckboxImageSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckboxImageSkin >> onSkinInstalledIn: anElement [

	| borderLook |
		
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 3).
	borderLook := ToBorderLook new
				initialPaint: anElement toTheme colorBorder;
				hoverPaint: anElement toTheme colorPrimaryHover;
				pressedPaint: anElement toTheme colorPrimaryPressed;
				width: 1.
	self addLook: borderLook.

	super onSkinInstalledIn: anElement

]
