Class {
	#name : #ToSkinUninstaller,
	#superclass : #Object,
	#category : 'Toplo-Core-Theme'
}

{ #category : #hook }
ToSkinUninstaller >> applyOn: anElement [

	anElement skinUninstaller: nil.
	" if there is not an installed skin -> nothing to do "

	anElement installedSkinDo: [ :s | 
		" have to dispatch UninstallStateRequest *** before *** removeEventHandler:
		If not, the uninstall state then the uninstallLookEvent will not be sent "
		s dispatchSkinUninstallStateRequestTo: anElement.
		" do not wait next pulse to flush skinStateQueue state 
		(to send ToUninstallLookEvent) "
		anElement updateStyles.
		" now remove the skin actually.
		no look event applied until a new skin is installed"
		anElement removeEventHandler: s.
		" ask to install the skin"
		anElement requestSkin ]
]

{ #category : #hook }
ToSkinUninstaller >> uninstallSkinIn: anElement [

	self
		deprecated: 'Use #applyOn:'
		transformWith: '`@receiver uninstallSkinIn: `@arg' -> '`@receiver applyOn: `@arg'.

	self applyOn: anElement
]
