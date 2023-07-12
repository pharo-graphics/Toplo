Class {
	#name : #ToButtonTextSkin,
	#superclass : #ToButtonUnborderedSkin,
	#classTraits : 'TObservable classTrait',
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonTextSkin >> onInstalledIconIn: anElement [

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
				hoverColor: anElement toTheme colorText;
				pressedColor: anElement toTheme colorText ].
	anElement icon addLook: formLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextSkin >> onInstalledLabelIn: anElement [

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
				initialColor: anElement toTheme colorText ].

	anElement label addLook: labelLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextSkin >> whenAddedToSpace: anEvent in: anElement [

	super whenAddedToSpace: anEvent in: anElement.
	self danger
		ifTrue: [
			self addLook: (ToBackgroundLook new
					 initialBg: Color transparent;
					 pressedBg: anElement toTheme colorErrorBg;
					 hoverBg: anElement toTheme colorErrorBg;
					 yourself) ]
		ifFalse: [
			self addLook: (ToBackgroundLook new
					 initialBg: Color transparent;
					 pressedBg: anElement toTheme colorBgTextActive;
					 hoverBg: anElement toTheme colorBgTextHover;
					 yourself) ]
]
