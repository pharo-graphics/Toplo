Class {
	#name : #ToButtonTextType,
	#superclass : #ToClickableType,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'basic button' }
ToButtonTextType >> basicButtonIconSkinIn: anElement [

	^ ToButtonTextIconSkin new danger: self danger
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> dangerBackgroundLookIn: anElement [

	^ ToBackgroundColorLook new
		  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
		  initialColor: [ :e | Color transparent ];
		  pressedColor: [ :e | e toTheme colorErrorBg ];
		  hoverColor: [ :e | e toTheme colorErrorBg ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundColorLook new
		  disabledColor: [ :e | e toTheme colorBgContainerDisabled ];
		  initialColor: [ :e | Color transparent ];
		  pressedColor: [ :e | e toTheme colorBgTextActive ];
		  hoverColor: [ :e | e toTheme colorBgTextHover ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelTextType new
]
