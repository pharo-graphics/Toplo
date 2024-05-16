Class {
	#name : #ToAnchorEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'windowManager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToAnchorEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	self windowManager currentWindowDo: [ :w |
		w applyPositionHookFromEvent: anEvent ]
]

{ #category : #'element handlers' }
ToAnchorEventHandler >> elementRemovedFromParentEvent: anEvent [

	self windowManager currentWindowDo: [ :cw | cw close ]
]

{ #category : #'element handlers' }
ToAnchorEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	self windowManager currentWindowDo: [ :cw |
		cw isOpened ifTrue: [ cw close ] ]
]

{ #category : #'api - accessing' }
ToAnchorEventHandler >> eventsToHandle [

	^ {
		  windowManager windowClosedEventClass.
		  windowManager windowOpenedEventClass.
		  BlElementRemovedFromParentEvent.
		  BlElementRemovedFromSceneGraphEvent.
		  BlElementPositionInSpaceChangedEvent }
]

{ #category : #'event handling' }
ToAnchorEventHandler >> windowClosedEvent: anEvent [

	anEvent windowManager = windowManager ifFalse: [ ^ self ].
	windowManager onWindowClosed 
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

	anEvent windowManager = windowManager ifFalse: [ ^ self ].
	windowManager onWindowOpened
]
