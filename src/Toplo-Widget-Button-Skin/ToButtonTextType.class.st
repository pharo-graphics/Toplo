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
		  whenDisabled: anElement toTheme colorBgContainerDisabled;
		  whenInitialized: Color transparent;
		  whenPressed: anElement toTheme colorErrorBg;
		  whenHovered: anElement toTheme colorErrorBg;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  whenDisabled: anElement toTheme colorBgContainerDisabled;
		  whenInitialized: Color transparent;
		  whenPressed: anElement toTheme colorBgTextActive;
		  whenHovered: anElement toTheme colorBgTextHover;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelTextType new
]
