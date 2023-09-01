Class {
	#name : #ToSelectInnerButtonSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Select-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToSelectInnerButtonSkin >> borderLookIn: anElement [

	^ self type selectInnerButtonBorderLookIn: anElement
]

{ #category : #accessing }
ToSelectInnerButtonSkin >> defaultType [

	^ ToButtonDefaultType new
]

{ #category : #accessing }
ToSelectInnerButtonSkin >> iconSkinIn: aButton [

	^ self type selectInnerButtonIconSkinIn: aButton
]

{ #category : #'api - install/uninstall  hook' }
ToSelectInnerButtonSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.

]
