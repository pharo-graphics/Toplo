Class {
	#name : 'ToSkin',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'removeFromSceneGraphHandler'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'style updating' }
ToSkin >> applyStylesIn: anElement [

	anElement skinStateQueue applyOn: anElement
]

{ #category : 'api - accessing' }
ToSkin >> eventsToHandle [

	^ { ToElementLookEvent }
]

{ #category : 'testing' }
ToSkin >> isNullSkin [

	^ false
]

{ #category : 'api - hooks' }
ToSkin >> onInstallStateRequestIn: anElement [
]

{ #category : 'api - hooks' }
ToSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement skinManager installedSkin: self.
	" install the event handler that generates state for the state engine"
	removeFromSceneGraphHandler := BlEventHandler
		                               on: BlElementRemovedFromSceneGraphEvent
		                               do: [ :evt | evt currentTarget requestUninstallSkin ].
	anElement addEventHandler: removeFromSceneGraphHandler
]

{ #category : 'api - hooks' }
ToSkin >> onUninstallStateRequestIn: anElement [
]

{ #category : 'api - hooks' }
ToSkin >> onUninstalledIn: anElement [

	anElement skinManager installedSkin: nil.
	anElement removeEventHandler: removeFromSceneGraphHandler.
	super onUninstalledIn: anElement.

]

{ #category : 'event handling' }
ToSkin >> uninstallLookEvent: anEvent [


]
