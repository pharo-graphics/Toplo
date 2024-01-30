Class {
	#name : #ToInstalledSkinContext,
	#superclass : #Object,
	#instVars : [
		'borderBuilder',
		'installedSkin',
		'textAttributesBuilder',
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

	self installedSkin: aSkin.

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
ToInstalledSkinContext >> installedSkin: aSkin [

	installedSkin := aSkin
]

{ #category : #accessing }
ToInstalledSkinContext >> textAttributesBuilder [

	^ textAttributesBuilder ifNil: [ textAttributesBuilder := BlTextDelegatedAttributesBuilder new ]
]

{ #category : #accessing }
ToInstalledSkinContext >> uninstallSkinIn: anElement [

	anElement removeEventHandler: removeFromSceneGraphHandler.
	anElement removeEventHandler: self installedSkin.
	self installedSkin: nil
]
