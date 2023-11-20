Class {
	#name : 'ToSkinInstaller',
	#superclass : 'Object',
	#instVars : [
		'installing'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'hook' }
ToSkinInstaller >> applyOn: anElement [
	" if there is an installed skin -> nothing to do "

	self install: [
		anElement installedSkin ifNil: [
			anElement defaultSkin ifNotNil: [ :found |
				anElement skinManager installSkin: found in: anElement ] ].
		anElement skinInstaller: nil ]
]

{ #category : 'initialization' }
ToSkinInstaller >> initialize [ 

	super initialize.
	installing := false
]

{ #category : 'hook' }
ToSkinInstaller >> install: aBlock [

	self installing: true.	
	aBlock value.
	self installing: false
]

{ #category : 'hook' }
ToSkinInstaller >> installSkinIn: anElement [

	self
		deprecated: 'Use applyOn:'
		transformWith: '`@receiver installSkinIn: `@argument' -> '`@receiver applyOn: `@argument'.

	self applyOn: anElement
]

{ #category : 'accessing' }
ToSkinInstaller >> installing [

	^ installing
]

{ #category : 'accessing' }
ToSkinInstaller >> installing: aBoolean [

	installing := aBoolean
]

{ #category : 'testing' }
ToSkinInstaller >> isInstalling [

	^ installing
]
