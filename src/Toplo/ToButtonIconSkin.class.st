Class {
	#name : #ToButtonIconSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'buttonType'
	],
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #accessing }
ToButtonIconSkin >> buttonType [

	^ buttonType
]

{ #category : #accessing }
ToButtonIconSkin >> buttonType: aButtonType [

	buttonType := aButtonType
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> onSkinInstalledIn: anElement [
		
	super onSkinInstalledIn: anElement.
	self addLook: (self buttonType iconLookIn: anElement)

	



]
