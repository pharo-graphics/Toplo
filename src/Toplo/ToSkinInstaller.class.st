Class {
	#name : 'ToSkinInstaller',
	#superclass : 'Object',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'hook' }
ToSkinInstaller >> applyOn: anElement [

	anElement skinInstaller: nil.
	" if there is an installed skin -> nothing to do "
	anElement installedSkinDo: [ :s |
		^ self ].
	anElement defaultSkin ifNotNil: [ :found |
		anElement skinManager installSkin: found in: anElement ]
]

{ #category : 'hook' }
ToSkinInstaller >> installSkinIn: anElement [

	self
		deprecated: 'Use applyOn:'
		transformWith: '`@receiver installSkinIn: `@argument' -> '`@receiver applyOn: `@argument'.

	self applyOn: anElement
]
