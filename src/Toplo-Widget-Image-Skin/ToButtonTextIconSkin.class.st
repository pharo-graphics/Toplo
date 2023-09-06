Class {
	#name : #ToButtonTextIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonTextIconSkin >> regularFormLookIn: anElement [

	^ ToMonoColorFlatImageFormLook new
		  disabledColor: [ :e | e toTheme colorImageDisabled ];
		  initialColor: [ :e | e toTheme colorText ];
		  hoverColor: [ :e | e toTheme colorText ];
		  pressedColor: [ :e | e toTheme colorText ];
		  yourself
]
