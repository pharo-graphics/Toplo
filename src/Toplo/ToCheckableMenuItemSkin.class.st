Class {
	#name : #ToCheckableMenuItemSkin,
	#superclass : #ToCheckableSkin,
	#category : #'Toplo-Widget-Menu-Skins'
}

{ #category : #'private - shaping/sizing' }
ToCheckableMenuItemSkin >> applyQuadShaping: aShaping on: anElement [

	(anElement layout isKindOf: BlLinearLayout) ifFalse: [
		anElement layout: BlLinearLayout new ].

	anElement padding: (self defaultPaddingIn: anElement).
	(anElement isSubmenu or: [ anElement isTopMenu not ]) ifTrue: [
		anElement hMatchParent ].
	anElement isTopMenu ifTrue: [ anElement interspaceWidth: anElement toTheme paddingXS ].
	anElement isSubmenu ifTrue: [
		anElement tripletStrategy: (ToTripletSubmenuColumnStrategy new width: anElement columnWidth) ]
]
