Class {
	#name : #ToButtonLinkType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularFormLookIn: anElement [

	| formLook |
	formLook := ToImageFormLook new.
	formLook
		initialColor: [ :e | e  toTheme colorLink];
		hoverColor: [ :e | e  toTheme colorLinkHover];
		pressedColor: [ :e | e  toTheme colorPrimaryPressed].
	^ formLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularLabelLookIn: anElement [

	| labelLook |
	labelLook := ToLabelTextLook new.
	labelLook
		initialColor: anElement toTheme colorLink;
		hoverColor: anElement toTheme colorLinkHover;
		pressedColor: anElement toTheme colorPrimaryPressed.
	^ labelLook
]
