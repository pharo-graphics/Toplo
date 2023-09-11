Class {
	#name : #ToButtonDefaultIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultIconSkin >> regularFormLookIn: anElement [

	^ ToLookDep new
		  applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
		  whenDisabled: [ :e | e toTheme colorImageDisabled ];
		  whenInitialized: [ :e | e toTheme colorText ];
		  whenHovered: [ :e | e toTheme colorPrimary ];
		  whenPressed: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
