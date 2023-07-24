Class {
	#name : #ToCheckboxImageSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckboxImageSkin >> onSkinInstalledIn: anElement [
		
	| borderLook |
	super onSkinInstalledIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 3).
	borderLook := ToBorderLook new
				initialPaint: [ :e | e toTheme colorBorder];
				hoverPaint: [ :e | e toTheme colorPrimaryHover];
				pressedPaint: [ :e | e toTheme colorPrimaryPressed];
				width: 1.
	self addLook: borderLook.

	



]
