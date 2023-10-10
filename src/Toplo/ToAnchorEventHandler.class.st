Class {
	#name : #ToAnchorEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'windowHandler'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToAnchorEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	windowHandler applyPositionHookFromEvent: anEvent
]

{ #category : #'element handlers' }
ToAnchorEventHandler >> elementRemovedFromParentEvent: anEvent [

	windowHandler closeWindow
]

{ #category : #'element handlers' }
ToAnchorEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	windowHandler closeWindow
]

{ #category : #'api - accessing' }
ToAnchorEventHandler >> eventsToHandle [ 

	^ { BlElementRemovedFromParentEvent. BlElementRemovedFromSceneGraphEvent. BlElementPositionInSpaceChangedEvent }
]

{ #category : #'api - accessing' }
ToAnchorEventHandler >> windowHandler: aWindowHandler [

	windowHandler := aWindowHandler
]
