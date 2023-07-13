Class {
	#name : #ToButtonDefaultSkin,
	#superclass : #ToButtonSkin,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'dashed'
	],
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #accessing }
ToButtonDefaultSkin >> dashed [

	^ dashed ifNil: [ dashed := false ]
]

{ #category : #accessing }
ToButtonDefaultSkin >> dashed: aBoolean [

	dashed := aBoolean
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> onInstalledIconIn: anElement [

	| formLook |
	super onInstalledIconIn: anElement.
	anElement icon ifNil: [ ^ self ].
	anElement icon withSkin: ToWidgetSkin new.
	formLook := ToImageFormLook new.
	self danger
		ifTrue: [
			formLook
				initialColor: anElement toTheme colorError;
				hoverColor: anElement toTheme colorErrorHover;
				pressedColor: anElement toTheme colorError darker ]
		ifFalse: [
			formLook
				initialColor: anElement toTheme colorText;
				hoverColor: anElement toTheme colorPrimary;
				pressedColor: anElement toTheme colorPrimaryPressed ].
	anElement icon addLook: formLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> onInstalledLabelIn: anElement [

	| labelLook attrBuilder |
	super onInstalledLabelIn: anElement.
	anElement label ifNil: [ ^ self ].
	anElement label withSkin: ToWidgetSkin new.
	attrBuilder := self textAttributesBuilderFromElement: anElement.
	labelLook := ToLabelTextLook new.
	labelLook attrBuilder: attrBuilder.
	self danger
		ifTrue: [
			labelLook
				initialColor: anElement toTheme colorError;
				hoverColor: anElement toTheme colorErrorHover;
				pressedColor: anElement toTheme colorErrorPressed ]
		ifFalse: [
			labelLook
				initialColor: anElement toTheme colorText;
				hoverColor: anElement toTheme colorPrimary;
				pressedColor: anElement toTheme colorPrimaryPressed ].

	anElement label addLook: labelLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonDefaultSkin >> whenAddedToSpace: anEvent in: anElement [

	| borderLook |
	super whenAddedToSpace: anEvent in: anElement.
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
	self addLook: borderLook
]
