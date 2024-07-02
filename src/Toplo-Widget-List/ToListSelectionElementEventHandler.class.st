Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'selectionMode'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListSelectionElementEventHandler class >> selectionMode: aSelectionMode [

	^ self new selectionMode: aSelectionMode
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	self refreshSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> differUpdateSelectionFrom: target [

]

{ #category : #'event handling' }
ToListSelectionElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	self refreshSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementScrolledEvent: anEvent [

	self refreshSelectionFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToListSelectionElementEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  BlBoundsHasChangedDuringScrollingEvent.
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent }
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> refreshSelectionFromEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	selectionMode refreshSelectionIn: target
]

{ #category : #accessing }
ToListSelectionElementEventHandler >> selectionMode: aSelectionMode [

	selectionMode := aSelectionMode
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target isAttachedToSceneGraph ifFalse: [
		self differUpdateSelectionFrom: target.
		^ self ].
	selectionMode updateSelectionIn: target
]
