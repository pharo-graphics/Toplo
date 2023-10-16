Class {
	#name : 'ToSkinInstaller',
	#superclass : 'Object',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'hook' }
ToSkinInstaller >> applyOn: anElement [

	anElement installedSkin ifNotNil: [ :s |
		anElement removeEventHandler: s ].
	(self defaultSkinIn: anElement) ifNotNil: [ :found |
		anElement installedSkin: found.
		anElement addEventHandler: found.
		anElement skinInstaller: nil.
		anElement dispatchSkinChangedEvent ]
]

{ #category : 'accessing' }
ToSkinInstaller >> defaultSkinIn: anElement [

	^ anElement defaultSkin
]
