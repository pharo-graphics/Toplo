Class {
	#name : #ToSkinUninstaller,
	#superclass : #Object,
	#category : 'Toplo-Core-Theme'
}

{ #category : #hook }
ToSkinUninstaller >> applyOn: anElement [

	anElement skinUninstaller: nil.
	" if there is an installed skin -> nothing to do "
	anElement installedSkinDo: [ :s | 
		" have to dispatch UninstallStateRequest *** before *** removeEventHandler:
		If not, the uninstall state the the uninstallLookEvent will not be sent.
		This is because removeEventHandler: actually remove the event handler and 
		then after send #onUninstalledIn: to the skin"
		s dispatchSkinUninstallStateRequestTo: anElement.
		" do not wait next pulse to flush skinStateQueue state 
		(to send ToUninstallLookEvent) "
		anElement updateStyles.
		anElement removeEventHandler: s ]
]

{ #category : #hook }
ToSkinUninstaller >> uninstallSkinIn: anElement [

	self
		deprecated: 'Use #applyOn:'
		transformWith: '`@receiver uninstallSkinIn: `@arg' -> '`@receiver applyOn: `@arg'.

	self applyOn: anElement
]
