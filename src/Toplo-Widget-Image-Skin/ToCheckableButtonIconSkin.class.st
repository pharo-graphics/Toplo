Class {
	#name : #ToCheckableButtonIconSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Image-Skin'
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
		              disabledStateValue: [ :e |
			              e toTheme colorBorderDisabled ];
		              initialStateValue: [ :e | e toTheme colorBorder ];
		              hoveredStateValue: [ :e | e toTheme colorPrimaryHover ];
		              pressedStateValue: [ :e |
			              e toTheme colorPrimaryPressed ].
	self addLook: borderLook
]
