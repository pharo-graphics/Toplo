Class {
	#name : #ToButtonPrimaryIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryIconSkin >> dangerFormLookIn: anElement [

	^ self regularFormLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimaryIconSkin >> regularFormLookIn: anElement [

	^ ToImageFormLook new
		  disabledStateValue: [ :e | e toTheme colorImageDisabled ];
		  initialStateValue: [ :e | e toTheme colorImageLightSolid ];
		  yourself
]
