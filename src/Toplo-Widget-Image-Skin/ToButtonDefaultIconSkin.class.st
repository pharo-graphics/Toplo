Class {
	#name : #ToButtonDefaultIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultIconSkin >> regularFormLookIn: anElement [

	^ ToMonoColorFlatImageFormLook new
		  disabledColor: [ :e | e toTheme colorImageDisabled ];
		  initialColor: [ :e | e toTheme colorText ];
		  hoverColor: [ :e | e toTheme colorPrimary ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
