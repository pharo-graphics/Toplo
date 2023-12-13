Class {
	#name : 'ToAnchorEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'windowManager'
	],
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'event handling' }
ToAnchorEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	windowManager currentWindow ifNil: [ ^ self ].
	windowManager applyPositionHookFromEvent: anEvent
]

{ #category : 'element handlers' }
ToAnchorEventHandler >> elementRemovedFromParentEvent: anEvent [

	windowManager closeWindow
]

{ #category : 'element handlers' }
ToAnchorEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	windowManager closeWindow
]

{ #category : 'api - accessing' }
ToAnchorEventHandler >> eventsToHandle [ 

	^ { BlElementRemovedFromParentEvent. BlElementRemovedFromSceneGraphEvent. BlElementPositionInSpaceChangedEvent }
]

{ #category : 'api - accessing' }
ToAnchorEventHandler >> windowManager: aWindowManager [

	windowManager := aWindowManager
]
