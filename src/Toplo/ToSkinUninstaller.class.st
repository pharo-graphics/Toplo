Class {
	#name : 'ToSkinUninstaller',
	#superclass : 'Object',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'hook' }
ToSkinUninstaller >> applyOn: anElement [

	anElement skinUninstaller: nil.
	" if there is not an installed skin -> nothing to do "
	anElement installedSkinDo: [ :skin |
		anElement skinManager uninstallSkin: skin in: anElement]
]

{ #category : 'hook' }
ToSkinUninstaller >> uninstallSkinIn: anElement [

	self
		deprecated: 'Use #applyOn:'
		transformWith: '`@receiver uninstallSkinIn: `@arg' -> '`@receiver applyOn: `@arg'.

	self applyOn: anElement
]
