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
		  disabledValue: anElement toTheme colorBgContainerDisabled;
		  initialValue: Color transparent;
		  pressedValue: anElement toTheme colorErrorBg;
		  hoveredValue: anElement toTheme colorErrorBg;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  disabledValue: anElement toTheme colorBgContainerDisabled;
		  initialValue: Color transparent;
		  pressedValue: anElement toTheme colorBgTextActive;
		  hoveredValue: anElement toTheme colorBgTextHover;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelTextType new
]
