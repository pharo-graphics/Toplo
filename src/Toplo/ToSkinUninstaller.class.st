Class {
	#name : #ToSkinUninstaller,
	#superclass : #Object,
	#category : #'Toplo-Core-Skin'
}

{ #category : #hook }
ToSkinUninstaller >> applyOn: anElement [

	" if there is not an installed skin -> nothing to do "
	anElement installedSkinDo: [ :skin |
		anElement dispatchEvent: (ToUninstallSkinEvent new skin: skin; yourself) ].
	anElement skinUninstaller: nil.

]
