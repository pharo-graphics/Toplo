Class {
	#name : #ToCheckableMenuItemSkin,
	#superclass : #ToCheckableSkin,
	#category : #'Toplo-Widget-Menu-Skins'
}

{ #category : #'private - shaping/sizing' }
ToCheckableMenuItemSkin >> applyQuadShaping: aShaping on: anElement [

	anElement padding: (self defaultPaddingIn: anElement).
	anElement interspace: anElement toTheme paddingXS.
	anElement isTopMenu ifFalse: [ anElement hMatchParent ].

]
