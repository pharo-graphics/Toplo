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

	^ ToLook new
		  applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
		  disabledValue: [ :e | e toTheme colorImageDisabled ];
		  initialValue: [ :e | e toTheme colorImageLightSolid ];
		  yourself
]
