Class {
	#name : 'ToSkinInstaller',
	#superclass : 'Object',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'hook' }
ToSkinInstaller >> applyOn: anElement [
"(anElement isKindOf: ToCheckbox) ifTrue: [ self halt ]."
	anElement skinInstaller: nil.
	" is there an already installed skin -> nothing to do "
	anElement skinDo: [ :s | ^ self ].
	anElement defaultSkin ifNotNil: [ :found | " add the skin as an element event handler"
		anElement addEventHandler: found.
		" event to update the state engine accordingly (add install or initial state)"
		found dispatchSkinInstallStateRequestTo: anElement.
		found dispatchSkinInitialStateRequestTo: anElement ]
]
