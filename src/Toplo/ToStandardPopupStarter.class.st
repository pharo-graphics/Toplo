Class {
	#name : #ToStandardPopupStarter,
	#superclass : #ToStandardWindowStarter,
	#instVars : [
		'anchorRootHandler',
		'windowHandler'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'starting-stopping' }
ToStandardPopupStarter >> startWindow: aWindow fromManager: aManager [

	super startWindow: aWindow fromManager: aManager.
	" add the handler to update the window layout (mainly its position and it hability to scroll).
	The window extent and the anchor root extent changes are to be monitored for that purpose "
	windowHandler ifNil: [
		windowHandler := aWindow
			                 addEventHandlerOn: BlElementExtentChangedEvent
			                 do: [ aWindow refreshLayout ] ].
	anchorRootHandler ifNil: [
		anchorRootHandler := aManager anchorRoot
			                     addEventHandlerOn: BlElementExtentChangedEvent
			                     do: [ :event | aWindow refreshLayout ] ]
]

{ #category : #'starting-stopping' }
ToStandardPopupStarter >> stopWindow: aWindow fromManager: aManager [

	"clean-up the window and the ancho root handlers added on opening"
	anchorRootHandler ifNotNil: [
		aManager anchorRoot removeEventHandler: anchorRootHandler.
		anchorRootHandler := nil ].
	windowHandler ifNotNil: [
		aWindow removeEventHandler: windowHandler.
		windowHandler := nil ].
	super stopWindow: aWindow fromManager: aManager
]
