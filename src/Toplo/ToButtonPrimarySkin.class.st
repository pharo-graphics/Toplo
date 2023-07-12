Class {
	#name : #ToButtonPrimarySkin,
	#superclass : #ToButtonSkin,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> onInstalledIconIn: anElement [

	| formLook |
	super onInstalledIconIn: anElement.
	anElement icon ifNil: [ ^ self ].
	anElement icon withSkin: ToWidgetSkin new.
	formLook := ToImageFormLook new
		            initialColor: anElement toTheme colorImageLightSolid;
		            yourself.
	anElement icon addLook: formLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> onInstalledLabelIn: anElement [

	| labelLook attrBuilder |
	super onInstalledLabelIn: anElement.
	anElement label ifNil: [ ^ self ].
	anElement label withSkin: ToWidgetSkin new.
	attrBuilder := self textAttributesBuilderFromElement: anElement.
	labelLook := ToLabelLook new.
	labelLook attrBuilder: attrBuilder.
	labelLook initialColor: anElement toTheme colorTextLightSolid.

	anElement label addLook: labelLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> whenAddedToSpace: anEvent in: anElement [

	super whenAddedToSpace: anEvent in: anElement.
	self danger
		ifTrue: [ self addLook: (ToBackgroundLook new
					initialBg: anElement toTheme colorError;
					 pressedBg: anElement toTheme colorErrorHover darker;
					 hoverBg: anElement toTheme colorErrorHover;
					 yourself) ]
		ifFalse: [
			self addLook: (ToBackgroundLook new
					initialBg: anElement toTheme colorPrimary;
					 pressedBg: anElement toTheme colorPrimaryPressed;
					 hoverBg: anElement toTheme colorPrimaryHover;
					 yourself) ]
]
