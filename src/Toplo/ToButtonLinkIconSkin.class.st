Class {
	#name : #ToButtonLinkIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkIconSkin >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledColor: [ :e | e toTheme colorImageDisabled ];
		  initialColor: [ :e | e toTheme colorLink ];
		  hoverColor: [ :e | e toTheme colorLinkHover ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
