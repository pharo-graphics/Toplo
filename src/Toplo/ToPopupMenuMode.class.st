Class {
	#name : #ToPopupMenuMode,
	#superclass : #ToPopupWindowMode,
	#instVars : [
		'anchorRootHandler'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'window handling' }
ToPopupMenuMode >> startWindow: aWindow [

	anchorRootHandler ifNil: [
		anchorRootHandler := self anchorRoot
			                     addEventHandlerOn: BlElementExtentChangedEvent
			                     do: [ :event | aWindow refreshLayout ] ].
	super startWindow: aWindow
]

{ #category : #'window handling' }
ToPopupMenuMode >> stopWindow: aWindow [

	anchorRootHandler ifNotNil: [
		self anchorRoot removeEventHandler: anchorRootHandler.
		anchorRootHandler := nil ].
	super stopWindow: aWindow 
]
