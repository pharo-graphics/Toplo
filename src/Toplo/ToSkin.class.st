Class {
	#name : 'ToSkin',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'skinStateGenerator',
		'removeFromSceneGraphHandler'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'event handling' }
ToSkin >> checkedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> clickedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> closedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> deselectedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> disabledLookEvent: anEvent [


]

{ #category : 'event dispatch' }
ToSkin >> dispatchSkinInitialStateRequestTo: anObject [

	anObject dispatchEvent: ToSkinInitialStateRequest new
]

{ #category : 'event dispatch' }
ToSkin >> dispatchSkinInstallStateRequestTo: anObject [

	anObject dispatchEvent: ToSkinInstallStateRequest new
]

{ #category : 'event dispatch' }
ToSkin >> dispatchSkinUninstallStateRequestTo: anObject [

	anObject dispatchEvent: ToSkinUninstallStateRequest new
]

{ #category : 'event handling' }
ToSkin >> dragStartedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> draggedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> droppedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> elementLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> enabledLookEvent: anEvent [


]

{ #category : 'api - accessing' }
ToSkin >> eventsToHandle [

	^ {
		  ToSkinEvent.
		  ToElementLookEvent }
]

{ #category : 'event handling' }
ToSkin >> focusedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> hoveredLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> indeterminateLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> initialLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> installLookEvent: anEvent [


]

{ #category : 'testing' }
ToSkin >> isNullSkin [

	^ false
]

{ #category : 'event handling' }
ToSkin >> leavedLookEvent: anEvent [


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
ToSkin >> onUninstalledIn: anElement [

	anElement skinManager installedSkin: nil.
	anElement removeEventHandler: removeFromSceneGraphHandler.
	super onUninstalledIn: anElement.

]

{ #category : 'event handling' }
ToSkin >> openedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> pressedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> releasedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> selectedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> skinInitialStateRequest: anEvent [

	anEvent currentTarget skinStateQueue skinInitialStateRequest: anEvent

]

{ #category : 'event handling' }
ToSkin >> skinInstallStateRequest: anEvent [

	anEvent currentTarget skinStateQueue
		skinInstallStateRequest: anEvent
]

{ #category : 'accessing' }
ToSkin >> skinStateGenerator [

	^ skinStateGenerator
]

{ #category : 'event handling' }
ToSkin >> skinUninstallStateRequest: anEvent [

	anEvent currentTarget skinStateQueue
		skinUninstallStateRequest: anEvent
]

{ #category : 'event handling' }
ToSkin >> stillHoveredLookEvent: anEvent [

]

{ #category : 'event handling' }
ToSkin >> stillPressedLookEvent: anEvent [

]

{ #category : 'event handling' }
ToSkin >> themeChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target installedSkin == self ifFalse: [
		Error signal: 'Baddly installed skin' ].
	target requestUninstallSkin.
	target requestSkin
]

{ #category : 'event handling' }
ToSkin >> uncheckedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> unfocusedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> uninstallLookEvent: anEvent [


]

{ #category : 'style updating' }
ToSkin >> updateStylesIn: anElement [

	anElement skinStateQueue applyOn: anElement
]
