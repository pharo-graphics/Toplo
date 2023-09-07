Class {
	#name : #ToButtonTextIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonTextIconSkin >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledStateValue: [ :e | e toTheme colorImageDisabled ];
		  initialStateValue: [ :e | e toTheme colorText ];
		  hoveredStateValue: [ :e | e toTheme colorText ];
		  pressedStateValue: [ :e | e toTheme colorText ];
		  yourself
]
