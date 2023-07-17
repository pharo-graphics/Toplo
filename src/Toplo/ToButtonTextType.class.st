Class {
	#name : #ToButtonTextType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

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

{ #category : #'api - install/uninstall  hook' }
ToButtonTextType >> whenAddedToSpace: anEvent in: anElement fromSkin: aSkin [

	super whenAddedToSpace: anEvent in: anElement fromSkin: aSkin.
	self danger
		ifTrue: [
			aSkin addLook: (ToBackgroundLook new
					 initialBg: Color transparent;
					 pressedBg: anElement toTheme colorErrorBg;
					 hoverBg: anElement toTheme colorErrorBg;
					 yourself) ]
		ifFalse: [
			aSkin addLook: (ToBackgroundLook new
					 initialBg: Color transparent;
					 pressedBg: anElement toTheme colorBgTextActive;
					 hoverBg: anElement toTheme colorBgTextHover;
					 yourself) ]
]
