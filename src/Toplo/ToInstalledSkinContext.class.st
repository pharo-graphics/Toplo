Class {
	#name : #ToInstalledSkinContext,
	#superclass : #Object,
	#instVars : [
		'borderBuilder',
		'installedSkin',
		'removeFromSceneGraphHandler'
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
	removeFromSceneGraphHandler := BlEventHandler
		                               on:
		                               BlElementRemovedFromSceneGraphEvent
		                               do: [ :evt |
			                               evt currentTarget skinManagerDo: [
				                               :sm |
				                               sm requestUninstallSkinIn:
					                               evt currentTarget ] ].
	anElement addEventHandler: removeFromSceneGraphHandler.
	anElement addEventHandler: aSkin.

]

{ #category : #accessing }
ToInstalledSkinContext >> installedSkin [

	^ installedSkin
]

{ #category : #accessing }
ToInstalledSkinContext >> uninstallSkinIn: anElement [

	anElement removeEventHandler: removeFromSceneGraphHandler.
	anElement removeEventHandler: installedSkin.
	installedSkin := nil
]
