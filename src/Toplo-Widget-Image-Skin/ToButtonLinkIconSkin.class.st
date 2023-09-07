Class {
	#name : #ToButtonLinkIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkIconSkin >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledStateValue: [ :e | e toTheme colorImageDisabled ];
		  initialStateValue: [ :e | e toTheme colorLink ];
		  hoveredStateValue: [ :e | e toTheme colorLinkHover ];
		  pressedStateValue: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
