Class {
	#name : #ToButtonDefaultIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultIconSkin >> regularFormLookIn: anElement [

	^ (super regularFormLookIn: anElement)
		when: ToDisabledLookEvent value: [ :e | e toTheme colorImageDisabled ];
		when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
		when: ToHoveredLookEvent value: [ :e | e toTheme colorPrimary ];
		when: ToPressedLookEvent value: [ :e | e toTheme colorPrimaryPressed ];
		yourself
]
