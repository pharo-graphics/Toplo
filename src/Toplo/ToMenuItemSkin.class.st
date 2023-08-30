Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToClickableSkin,
	#category : #'Toplo-Widget-Menu-Skins'
}

{ #category : #'private - shaping/sizing' }
ToMenuItemSkin >> applyQuadShaping: aShaping on: anElement [

	anElement padding: (self defaultPaddingIn: anElement).
	anElement interspace: anElement toTheme paddingXS.
	anElement isTopMenu ifTrue: [ ^ self ].
	anElement hMatchParent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemSkin >> backgroundLookIn: anElement [

	^ (self type menuItemBackgroundLookIn: anElement)
		  duration: 200 milliSeconds;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemSkin >> borderLookIn: anElement [

	^ self type menuItemBorderLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemSkin >> checkItem: aMenuItem [
]

{ #category : #'t - shapeable - initialization' }
ToMenuItemSkin >> defaultShaping [

	^ ToRectangleShaping new
		  yourself
]

{ #category : #accessing }
ToMenuItemSkin >> defaultType [

	^ ToButtonTextType new
]

{ #category : #accessing }
ToMenuItemSkin >> iconSkinIn: aButton [

	^ self type menuItemIconSkinIn: aButton

]

{ #category : #accessing }
ToMenuItemSkin >> labelSkinIn: aButton [
 
	^ self type menuItemLabelSkinIn: aButton
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToWindowLook new 
		openAction: [ :e | self checkItem: e ])
]
