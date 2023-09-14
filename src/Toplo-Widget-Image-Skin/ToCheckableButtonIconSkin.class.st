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
	borderLook := (anElement styleSheet newLookUpdaterForPropertyName: #border)
		when: ToDisabledLookEvent value: [ :e | e toTheme colorBorderDisabled ];
		when: ToInitialLookEvent value: [ :e | e toTheme colorBorder ];
		when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimaryHover ];
		when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
		yourself.
	self addLookUpdater: borderLook
]
