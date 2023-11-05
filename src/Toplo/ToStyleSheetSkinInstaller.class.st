Class {
	#name : 'ToStyleSheetSkinInstaller',
	#superclass : 'ToSkinInstaller',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'hook' }
ToStyleSheetSkinInstaller >> applyOn: anElement [

	anElement skinInstaller: nil.
	" is there an already installed skin"
	anElement installedSkin ifNotNil: [ :s |
		s isNullSkin ifTrue: [ ^ self ].
		^ s dispatchSkinInitialStateRequestTo: anElement ].
	anElement defaultSkin ifNotNil: [ :found | " add the skin as an element event handler"
		anElement addEventHandler: found.
		" event to update the state engine accordingly (add install or initial state)"
		found dispatchSkinInstallStateRequestTo: anElement.
		found dispatchSkinInitialStateRequestTo: anElement ]
]
