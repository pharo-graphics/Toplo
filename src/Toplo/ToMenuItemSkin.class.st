Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToClickableSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'private - shaping/sizing' }
ToMenuItemSkin >> applyQuadShaping: aShaping on: anElement [

	anElement layout: BlLinearLayout new.
	anElement padding: (self defaultPaddingIn: anElement).
	(anElement isSubmenu or: [ anElement isTopMenu not ]) ifTrue: [
		anElement hMatchParent ].
	anElement isSubmenu ifTrue: [
		anElement tripletStrategy: (ToTripletSubmenuColumnStrategy new width: anElement defaultColumnWidth) ]
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemSkin >> backgroundLookIn: anElement [

	^ self type menuItemBackgroundLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemSkin >> borderLookIn: anElement [

	^ self type menuItemBorderLookIn: anElement
]

{ #category : #'t - shapeable - initialization' }
ToMenuItemSkin >> defaultShaping [

	^ ToRectangleShaping new
		  radius: 0;
		  yourself
]

{ #category : #accessing }
ToMenuItemSkin >> defaultType [

	^ ToButtonDefaultType new
]

{ #category : #accessing }
ToMenuItemSkin >> iconSkinIn: aButton [

	^ self type menuItemIconSkinIn: aButton

]

{ #category : #accessing }
ToMenuItemSkin >> labelSkinIn: aButton [
 
	^ self type menuItemLabelSkinIn: aButton
]
