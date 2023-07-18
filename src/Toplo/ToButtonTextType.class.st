Class {
	#name : #ToButtonTextType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> backgroundLookIn: anElement [

	^ self danger
		  ifTrue: [
			  ToBackgroundLook new
				  initialBg: [:e | Color transparent];
				  pressedBg: [:e | e toTheme colorErrorBg];
				  hoverBg: [:e | e toTheme colorErrorBg];
				  yourself ]
		  ifFalse: [
			  ToBackgroundLook new
				  initialBg: [:e | Color transparent];
				  pressedBg: [:e | e toTheme colorBgTextActive];
				  hoverBg: [:e | e toTheme colorBgTextHover];
				  yourself ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularFormLookIn: anElement [

	| formLook |
	formLook := ToImageFormLook new.
	formLook
		initialColor: anElement toTheme colorText;
		hoverColor: anElement toTheme colorText;
		pressedColor: anElement toTheme colorText.
	^ formLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> regularLabelLookIn: anElement [

	| labelLook |
	labelLook := ToLabelTextLook new.
	labelLook initialColor: anElement toTheme colorText.
	^ labelLook
]
