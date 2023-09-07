Class {
	#name : #ToButtonDefaultIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultIconSkin >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledStateValue: [ :e | e toTheme colorImageDisabled ];
		  initialStateValue: [ :e | e toTheme colorText ];
		  hoveredStateValue: [ :e | e toTheme colorPrimary ];
		  pressedStateValue: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
