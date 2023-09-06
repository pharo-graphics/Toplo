Class {
	#name : #ToButtonLinkIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkIconSkin >> regularFormLookIn: anElement [

	^ ToMonoColorFlatImageFormLook new
		  disabledColor: [ :e | e toTheme colorImageDisabled ];
		  initialColor: [ :e | e toTheme colorLink ];
		  hoverColor: [ :e | e toTheme colorLinkHover ];
		  pressedColor: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
