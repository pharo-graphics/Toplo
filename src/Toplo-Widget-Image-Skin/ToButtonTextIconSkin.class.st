Class {
	#name : #ToButtonTextIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonTextIconSkin >> regularFormLookIn: anElement [

	^ ToLook new
		  applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
		  disabledValue: [ :e | e toTheme colorImageDisabled ];
		  initialValue: [ :e | e toTheme colorText ];
		  hoveredValue: [ :e | e toTheme colorText ];
		  pressedValue: [ :e | e toTheme colorText ];
		  yourself
]
