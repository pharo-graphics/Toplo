Class {
	#name : #ToButtonIconSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'buttonSkin'
	],
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #accessing }
ToButtonIconSkin >> buttonSkin [

	^ buttonSkin
]

{ #category : #accessing }
ToButtonIconSkin >> buttonSkin: aButtonSkin [

	buttonSkin := aButtonSkin
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> onSkinInstalledIn: anElement [
		
	super onSkinInstalledIn: anElement.
	self addLook: (self buttonSkin iconLookIn: anElement)

	



]
