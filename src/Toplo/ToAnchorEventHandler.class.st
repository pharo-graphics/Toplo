Class {
	#name : #ToAnchorEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'windowManager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToAnchorEventHandler >> anchoredWindowOpenRequest: anEvent [
]

{ #category : #'event handling' }
ToAnchorEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	windowManager elementAddedToSceneGraphEvent: anEvent
]

{ #category : #'event handling' }
ToAnchorEventHandler >> elementExtentChangedEvent: anEvent [

	windowManager elementExtentChangedEvent: anEvent
]

{ #category : #'event handling' }
ToAnchorEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	windowManager elementPositionInSpaceChangedEvent: anEvent
]

{ #category : #'event handling' }
ToAnchorEventHandler >> elementRemovedFromParentEvent: anEvent [

	windowManager elementRemovedFromParentEvent: anEvent
]

{ #category : #'event handling' }
ToAnchorEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	windowManager elementRemovedFromSceneGraphEvent: anEvent
]

{ #category : #'api - accessing' }
ToAnchorEventHandler >> eventsToHandle [

	^ self windowEventsToHandle , {
		  BlElementExtentChangedEvent.
		  BlElementRemovedFromParentEvent.
		  BlElementAddedToSceneGraphEvent.
		  BlElementRemovedFromSceneGraphEvent.
		  BlElementPositionInSpaceChangedEvent }
]

{ #category : #'event handling' }
ToAnchorEventHandler >> windowClosedEvent: anEvent [

	windowManager windowClosedEvent: anEvent
]

{ #category : #'api - accessing' }
ToAnchorEventHandler >> windowEventsToHandle [

	^ { ToAnchoredWindowOpenRequest }
]

{ #category : #'api - accessing' }
ToAnchorEventHandler >> windowManager [

	^ windowManager
]

{ #category : #'api - accessing' }
ToAnchorEventHandler >> windowManager: aWindowManager [

	windowManager := aWindowManager
]

{ #category : #'event handling' }
ToAnchorEventHandler >> windowOpenedEvent: anEvent [

	windowManager windowOpenedEvent: anEvent
]
