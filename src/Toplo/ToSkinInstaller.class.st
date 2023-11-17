Class {
	#name : 'ToSkinInstaller',
	#superclass : 'Object',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'hook' }
ToSkinInstaller >> applyOn: anElement [
	" if there is an installed skin -> nothing to do "

	anElement installedSkin ifNil: [
		anElement defaultSkin ifNotNil: [ :found |
			anElement skinManager installSkin: found in: anElement ] ].
	anElement skinInstaller: nil
]

{ #category : 'hook' }
ToSkinInstaller >> installSkinIn: anElement [

	self
		deprecated: 'Use applyOn:'
		transformWith: '`@receiver installSkinIn: `@argument' -> '`@receiver applyOn: `@argument'.

	self applyOn: anElement
]
