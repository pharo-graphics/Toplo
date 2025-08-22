Class {
	#name : #ToInstalledSkinContext,
	#superclass : #Object,
	#instVars : [
		'borderBuilder',
		'installedSkin',
		'removedFromSpaceHandler'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #accessing }
ToInstalledSkinContext >> borderBuilder [

	^ borderBuilder ifNil: [ borderBuilder := BlBorderBuilder new ]
]

{ #category : #accessing }
ToInstalledSkinContext >> installSkin: aSkin in: anElement [

	installedSkin = aSkin ifTrue: [ ^ self ].

	self
		assert: [ (anElement eventDispatcher handlers includes: aSkin) not ]
		description: [ 'The skin must not be already registered!' ].

	installedSkin := aSkin.

	" install the event handler that will ask for a skin uninstaller when element is removed from space"
	removedFromSpaceHandler := BlEventHandler
		                           on: ToRemovedFromSpaceEvent
		                           do: [ :evt |
			                           evt currentTarget skinManagerDo: [ :sm |
				                           sm requestUninstallSkinIn:
					                           evt currentTarget ] ].
	anElement addEventHandler: removedFromSpaceHandler.
	anElement addEventHandler: aSkin
]

{ #category : #accessing }
ToInstalledSkinContext >> installedSkin [

	^ installedSkin
]

{ #category : #accessing }
ToInstalledSkinContext >> uninstallSkinIn: anElement [

	anElement removeEventHandler: removedFromSpaceHandler.
	anElement removeEventHandler: installedSkin.
	installedSkin := nil
]
