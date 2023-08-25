Class {
	#name : #ToButtonDefaultIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultIconSkin >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledColor: [ :e | e toTheme colorImageDisabled ];
		  initialColor: [ :e | e toTheme colorText ];
		  hoverColor: [ :e | e toTheme colorPrimary ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
