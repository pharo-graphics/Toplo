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

	^ ToLookUpdater new 
		property: (ToPseudoProperty new 
			name: #'form-foreground'; 
			writer: [ :e :v | self adaptForegroundIn: e withColor: v] );
		when: ToDisabledLookEvent value: [ :e | e toTheme colorImageDisabled ];
		when: ToInitialLookEvent value: [ :e | e toTheme colorImageLightSolid ];
		yourself
]
