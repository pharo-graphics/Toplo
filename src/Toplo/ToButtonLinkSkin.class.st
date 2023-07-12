Class {
	#name : #ToButtonLinkSkin,
	#superclass : #ToButtonUnborderedSkin,
	#classTraits : 'TObservable classTrait',
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkSkin >> onInstalledIconIn: anElement [

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
				initialColor: anElement toTheme colorLink;
				hoverColor: anElement toTheme colorLinkHover;
				pressedColor: anElement toTheme colorPrimaryPressed ].
	anElement icon addLook: formLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkSkin >> onInstalledLabelIn: anElement [

	| labelLook attrBuilder |
	super onInstalledLabelIn: anElement.
	anElement label ifNil: [ ^ self ].
	anElement label withSkin: ToWidgetSkin new.
	attrBuilder := self textAttributesBuilderFromElement: anElement.
	labelLook := ToLabelLook new.
	labelLook attrBuilder: attrBuilder.
	self danger
		ifTrue: [
			labelLook
				initialColor: anElement toTheme colorError;
				hoverColor: anElement toTheme colorErrorHover;
				pressedColor: anElement toTheme colorErrorPressed ]
		ifFalse: [
			labelLook
				initialColor: anElement toTheme colorPrimary;
				hoverColor: anElement toTheme colorLinkHover;
				pressedColor: anElement toTheme colorPrimaryPressed ].

	anElement label addLook: labelLook
]
