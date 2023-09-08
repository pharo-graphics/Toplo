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
	borderLook := ToLook new
		              applyWith: [ :e :v | e border: v asBlBorder ];
		              disabledValue: [ :e |
			              e toTheme colorBorderDisabled ];
		              initialValue: [ :e | e toTheme colorBorder ];
		              hoveredValue: [ :e | e toTheme colorPrimaryHover ];
		              pressedValue: [ :e |
			              e toTheme colorPrimaryPressed ].
	self addLook: borderLook
]
