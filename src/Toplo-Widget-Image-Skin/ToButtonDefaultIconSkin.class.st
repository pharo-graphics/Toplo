Class {
	#name : #ToButtonDefaultIconSkin,
	#superclass : #ToButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultIconSkin >> regularFormLookIn: anElement [

	^ ToLook new
		  applyWith: [ :e :v | self adaptForegroundIn: e withColor: v ];
		  disabledValue: [ :e | e toTheme colorImageDisabled ];
		  initialValue: [ :e | e toTheme colorText ];
		  hoveredValue: [ :e | e toTheme colorPrimary ];
		  pressedValue: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
