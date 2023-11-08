Class {
	#name : 'ToSkinInstaller',
	#superclass : 'Object',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'hook' }
ToSkinInstaller >> installSkinIn: anElement [

	anElement skinInstaller: nil.
	" if there is an installed skin -> nothing to do "
	anElement installedSkinDo: [ :s | ^ self ].
	anElement defaultSkin ifNotNil: [ :found |
		anElement addEventHandler: found.
		found dispatchSkinInstallStateRequestTo: anElement.
		found dispatchSkinInitialStateRequestTo: anElement ]
]
