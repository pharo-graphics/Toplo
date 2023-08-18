Class {
	#name : #ToCheckableButtonIconSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonIconSkin >> geometryIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonIconSkin >> onSkinInstalledIn: anElement [
		
	| borderLook |
	super onSkinInstalledIn: anElement.
	anElement geometry: (self geometryIn: anElement).
	borderLook := ToBorderLook new
				disabledPaint: [ :e | e toTheme colorBorderDisabled ];
				initialPaint: [ :e | e toTheme colorBorder];
				hoverPaint: [ :e | e toTheme colorPrimaryHover];
				pressedPaint: [ :e | e toTheme colorPrimaryPressed];
				width: [ :e | e toTheme lineWidth ].
	self addLook: borderLook.

	

]
