Class {
	#name : #ToButtonDefaultType,
	#superclass : #ToButtonType,
	#instVars : [
		'dashed'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToButtonDefaultType >> dashed [

	^ dashed ifNil: [ dashed := false ]
]

{ #category : #accessing }
ToButtonDefaultType >> dashed: aBoolean [

	dashed := aBoolean
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularFormLookIn: anElement [

	| formLook |
	formLook := ToImageFormLook new.
	formLook
		initialColor: anElement toTheme colorText;
		hoverColor: anElement toTheme colorPrimary;
		pressedColor: anElement toTheme colorPrimaryPressed.
	^ formLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> regularLabelLookIn: anElement [

	| labelLook |
	labelLook := ToLabelTextLook new.
	labelLook
		initialColor: anElement toTheme colorText;
		hoverColor: anElement toTheme colorPrimary;
		pressedColor: anElement toTheme colorPrimaryPressed.
	^ labelLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultType >> whenAddedToSpace: anEvent in: anElement fromSkin: aSkin [

	| borderLook |
	super whenAddedToSpace: anEvent in: anElement fromSkin: aSkin.
	borderLook := ToBorderLook new.
	self dashed ifTrue: [ borderLook dashArray: anElement toTheme dashed ].
	self danger
		ifTrue: [
			borderLook
				initialPaint: anElement toTheme colorError;
				hoverPaint: anElement toTheme colorErrorHover;
				pressedPaint: anElement toTheme colorErrorHover darker ]
		ifFalse: [
			borderLook
				initialPaint: anElement toTheme colorBorder;
				hoverPaint: anElement toTheme colorPrimaryHover;
				pressedPaint: anElement toTheme colorPrimaryPressed ].
	borderLook width: anElement toTheme lineWidth.
	aSkin addLook: borderLook
]
