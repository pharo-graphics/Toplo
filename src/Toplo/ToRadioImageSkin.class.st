Class {
	#name : #ToRadioImageSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToRadioImageSkin >> onSkinInstalledIn: anElement [

	| borderLook |
		
	super onSkinInstalledIn: anElement.
	anElement geometry: (BlCircleGeometry new).
	borderLook := ToBorderLook new
				initialPaint: [ :e | e toTheme colorBorder];
				hoverPaint: [ :e | e toTheme colorPrimaryHover];
				pressedPaint: [ :e | e toTheme colorPrimaryPressed];
				width: [ :e | e toTheme lineWidth ].
	self addLook: borderLook.



]
