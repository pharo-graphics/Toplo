Class {
	#name : #ToButtonDefaultType,
	#superclass : #ToButtonType,
	#instVars : [
		'dashed'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToButtonDefaultType >> borderLookIn: anElement [

	| borderLook |
	borderLook := ToBorderLook new.
	self dashed ifTrue: [
		borderLook dashArray: [ :e | e toTheme dashArray ] ].
	self danger
		ifTrue: [
			borderLook
				initialPaint: [ :e | e toTheme colorError ];
				hoverPaint: [ :e | e toTheme colorErrorHover ];
				pressedPaint: [ :e | e toTheme colorErrorHover darker ] ]
		ifFalse: [
			borderLook
				initialPaint: [ :e | e toTheme colorBorder ];
				hoverPaint: [ :e | e toTheme colorPrimaryHover ];
				pressedPaint: [ :e | e toTheme colorPrimaryPressed ] ].
	borderLook width: [ :e | e toTheme lineWidth ].
	^ borderLook
]

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
		initialColor: [ :e | e toTheme colorText];
		hoverColor: [ :e | e  toTheme colorPrimary];
		pressedColor: [ :e | e toTheme colorPrimaryPressed].
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
