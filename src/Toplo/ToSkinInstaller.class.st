Class {
	#name : 'ToSkinInstaller',
	#superclass : 'Object',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'hook' }
ToSkinInstaller >> applyOn: anElement [

	anElement skinInstaller: nil.
	" is there an already installed skin"
	anElement installedSkin ifNotNil: [ :s |
		" one have to remove the skin from the element "
		anElement removeEventHandler: s ].
	anElement defaultSkin ifNotNil: [ :found |
		" add the skin as an element event handler"
		anElement addEventHandler: found.
		" event to update the state engine accordingly (add install or initial state)"
		anElement dispatchSkinChangedEvent ]
]
