Class {
	#name : #ToWidgetInWindowEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'window'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'element handlers' }
ToWidgetInWindowEventHandler >> elementRemovedFromParentEvent: anEvent [

	self window close
]

{ #category : #'element handlers' }
ToWidgetInWindowEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	self window close
]

{ #category : #'api - accessing' }
ToWidgetInWindowEventHandler >> eventsToHandle [
	^ { BlElementRemovedFromParentEvent. BlElementRemovedFromSceneGraphEvent }
]

{ #category : #accessing }
ToWidgetInWindowEventHandler >> window [

	^ window
]

{ #category : #accessing }
ToWidgetInWindowEventHandler >> window: aWindow [

	window := aWindow
]
