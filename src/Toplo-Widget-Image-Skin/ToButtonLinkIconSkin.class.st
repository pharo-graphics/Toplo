Class {
	#name : #ToButtonLinkIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkIconSkin >> regularFormLookIn: anElement [

	^ ToLook new
		  applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
		  disabledValue: [ :e | e toTheme colorImageDisabled ];
		  initialValue: [ :e | e toTheme colorLink ];
		  hoveredValue: [ :e | e toTheme colorLinkHover ];
		  pressedValue: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
