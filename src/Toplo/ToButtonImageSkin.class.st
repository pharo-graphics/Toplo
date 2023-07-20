Class {
	#name : #ToButtonImageSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'buttonType'
	],
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #accessing }
ToButtonImageSkin >> buttonType [

	^ buttonType
]

{ #category : #accessing }
ToButtonImageSkin >> buttonType: aButtonType [

	buttonType := aButtonType
]

{ #category : #'api - install/uninstall  hook' }
ToButtonImageSkin >> onSkinInstalledIn: anElement [

	| iconLook |
	iconLook := self buttonType iconLookIn: anElement.
	self addLook: iconLook.
	super onSkinInstalledIn: anElement

]
