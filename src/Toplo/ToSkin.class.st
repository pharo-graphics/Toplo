Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'removeFromSceneGraphHandler'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - accessing' }
ToSkin >> eventsToHandle [

	^ { ToElementLookEvent }
]

{ #category : #testing }
ToSkin >> isNullSkin [

	^ false
]

{ #category : #'api - hooks' }
ToSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement ensuredSkinManager installedSkin: self.
	" install the event handler that will ask for a skin uninstaller when element is removed from space"
	removeFromSceneGraphHandler := BlEventHandler
		                               on:
		                               BlElementRemovedFromSceneGraphEvent
		                               do: [ :evt |
			                               evt currentTarget skinManagerDo: [
				                               :sm |
				                               sm requestUninstallSkinIn:
					                               evt currentTarget ] ].
	anElement addEventHandler: removeFromSceneGraphHandler
]

{ #category : #'api - hooks' }
ToSkin >> onUninstalledIn: anElement [

	anElement skinManager installedSkin: nil.
	anElement removeEventHandler: removeFromSceneGraphHandler.
	super onUninstalledIn: anElement.

]
