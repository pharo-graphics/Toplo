Class {
	#name : #ToButtonLabelSkin,
	#superclass : #ToBasicLabelSkin,
	#instVars : [
		'buttonSkin'
	],
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToButtonLabelSkin >> buttonSkin [

	^ buttonSkin
]

{ #category : #accessing }
ToButtonLabelSkin >> buttonSkin: aButtonSkin [

	buttonSkin := aButtonSkin
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLabelSkin >> onSkinInstalledIn: anElement [

	| labelLook attrBuilder |
	super onSkinInstalledIn: anElement.
	attrBuilder := self textAttributesBuilderFromElement: anElement.
	labelLook := self buttonSkin labelLookIn: anElement.
	labelLook attrBuilder: attrBuilder.
	self addLook: labelLook

]
