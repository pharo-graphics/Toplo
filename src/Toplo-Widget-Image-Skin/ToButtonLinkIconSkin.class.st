Class {
	#name : #ToButtonLinkIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkIconSkin >> regularFormLookIn: anElement [

	^ ToLookDep new
		  applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
		  whenDisabled: [ :e | e toTheme colorImageDisabled ];
		  whenInitialized: [ :e | e toTheme colorLink ];
		  whenHovered: [ :e | e toTheme colorLinkHover ];
		  whenPressed: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
