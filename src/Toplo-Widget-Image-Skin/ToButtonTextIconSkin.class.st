Class {
	#name : #ToButtonTextIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonTextIconSkin >> regularFormLookIn: anElement [

	^ (super regularFormLookIn: anElement)
		when: ToDisabledLookEvent value: [ :e | e toTheme colorImageDisabled ];
		when: ToInitialLookEvent value: [ :e | e toTheme colorText ];
		when: ToHoveredLookEvent value: [ :e | e toTheme colorText ];
		when: ToPressedLookEvent value: [ :e | e toTheme colorText  ];
		yourself


]
