Class {
	#name : #ToSkinUninstaller,
	#superclass : #Object,
	#category : #'Toplo-Core-Skin'
}

{ #category : #hook }
ToSkinUninstaller >> applyOn: anElement [
	" if there is not an installed skin -> nothing to do "

	anElement skinManagerDo: [ :sm |
		sm uninstallSkinIn: anElement.
		sm setSkinUninstaller: nil in: anElement ]
]
