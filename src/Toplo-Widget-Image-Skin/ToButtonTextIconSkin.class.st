Class {
	#name : #ToButtonTextIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonTextIconSkin >> regularFormLookIn: anElement [

	^ ToLook new
		  applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
		  whenDisabled: [ :e | e toTheme colorImageDisabled ];
		  whenInitialized: [ :e | e toTheme colorText ];
		  whenHovered: [ :e | e toTheme colorText ];
		  whenPressed: [ :e | e toTheme colorText ];
		  yourself
]
