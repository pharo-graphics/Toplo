Class {
	#name : #ToStandardPopupStarter,
	#superclass : #ToStandardWindowStarter,
	#instVars : [
		'anchorRootHandler'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'starting-stopping' }
ToStandardPopupStarter >> startWindow: aWindow fromManager: aManager [

	super startWindow: aWindow fromManager: aManager.
	anchorRootHandler ifNil: [
		anchorRootHandler := aManager anchorRoot
			                     addEventHandlerOn: BlElementExtentChangedEvent
			                     do: [ :event | aWindow refreshLayout ] ]
]

{ #category : #'starting-stopping' }
ToStandardPopupStarter >> stopWindow: aWindow fromManager: aManager [

	anchorRootHandler ifNotNil: [
		aManager anchorRoot removeEventHandler: anchorRootHandler.
		anchorRootHandler := nil ].
	super stopWindow: aWindow fromManager: aManager.

]
