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
		  whenDisabled: [ :e | e toTheme colorImageDisabled ];
		  whenInitialized: [ :e | e toTheme colorImageLightSolid ];
		  yourself
]
