Class {
	#name : #ToButtonLabelSkin,
	#superclass : #ToBasicLabelSkin,
	#instVars : [
		'buttonType'
	],
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToButtonLabelSkin >> buttonType [

	^ buttonType
]

{ #category : #accessing }
ToButtonLabelSkin >> buttonType: aButtonType [

	buttonType := aButtonType
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLabelSkin >> onSkinInstalledIn: anElement [

	| labelLook attrBuilder |
	super onSkinInstalledIn: anElement.
	attrBuilder := self textAttributesBuilderFromElement: anElement.
	labelLook := self buttonType labelLookIn: anElement.
	labelLook attrBuilder: attrBuilder.
	self addLook: labelLook

]
