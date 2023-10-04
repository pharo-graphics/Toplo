Class {
	#name : #ToElementWithWindowEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#instVars : [
		'window'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'element handlers' }
ToElementWithWindowEventHandler >> elementRemovedFromParentEvent: anEvent [

	self window close
]

{ #category : #'element handlers' }
ToElementWithWindowEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	self window close
]

{ #category : #'api - accessing' }
ToElementWithWindowEventHandler >> eventsToHandle [
	^ super eventsToHandle, { BlElementRemovedFromParentEvent. BlElementRemovedFromSceneGraphEvent }
]

{ #category : #accessing }
ToElementWithWindowEventHandler >> window [

	^ window
]

{ #category : #accessing }
ToElementWithWindowEventHandler >> window: aWindow [

	window := aWindow
]
