Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToClickableSkin,
	#category : #'Toplo-Widget-Menu-Skins'
}

{ #category : #'private - shaping/sizing' }
ToMenuItemSkin >> applyQuadShaping: aShaping on: anElement [

	(anElement layout isKindOf: BlLinearLayout) ifFalse: [ 
		anElement layout: BlLinearLayout new].

	anElement padding: (self defaultPaddingIn: anElement).
	(anElement isSubmenu or: [ anElement isTopMenu not ]) ifTrue: [
		anElement hMatchParent ].
	anElement isTopMenu ifTrue: [ anElement interspace: anElement toTheme paddingXS ].
	"anElement isSubmenu ifTrue: [
		anElement tripletStrategy: (ToTripletSubmenuColumnStrategy new width: anElement columnWidth) ]"
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
