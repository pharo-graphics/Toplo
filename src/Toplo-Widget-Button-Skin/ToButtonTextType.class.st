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

	^ ToBackgroundLook new
		  disabledStateValue: anElement toTheme colorBgContainerDisabled;
		  initialStateValue: Color transparent;
		  pressedStateValue: anElement toTheme colorErrorBg;
		  hoverStateValue: anElement toTheme colorErrorBg;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  disabledStateValue: anElement toTheme colorBgContainerDisabled;
		  initialStateValue: Color transparent;
		  pressedStateValue: anElement toTheme colorBgTextActive;
		  hoverStateValue: anElement toTheme colorBgTextHover;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelTextType new
]
