Class {
	#name : #ToCheckableMenuItemSkin,
	#superclass : #ToCheckableSkin,
	#category : #'Toplo-Widget-Menu-Skins'
}

{ #category : #'private - shaping/sizing' }
ToCheckableMenuItemSkin >> applyQuadShaping: aShaping on: anElement [

	anElement layout: BlLinearLayout new.
	anElement padding: (self defaultPaddingIn: anElement).
	(anElement isSubmenu or: [ anElement isTopMenu not ]) ifTrue: [
		anElement hMatchParent ].
	anElement isTopMenu ifTrue: [ anElement spacingWidth: 5 ].
	anElement isSubmenu ifTrue: [
		anElement tripletStrategy: (ToTripletSubmenuColumnStrategy new width: anElement defaultColumnWidth) ]
]
