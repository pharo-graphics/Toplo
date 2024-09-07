Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'selectionGroupHolder'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	self refreshSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> differUpdateSelectionFrom: target [

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
		  BlBoundsHasChangedDuringScrollingEvent.
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent }
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> refreshSelectionFromEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	selectionGroupHolder refreshSelectionIn: target
]

{ #category : #accessing }
ToListSelectionElementEventHandler >> selectionGroupHolder: aSelectionGroupHolder [

	selectionGroupHolder := aSelectionGroupHolder
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updateSelectionFromEvent: anEvent [
	" the selection has changed but the touched indexes is empty means 
	that a selection element remains for removed indexes"

	| target |
	target := anEvent currentTarget.
	anEvent touchedIndexes ifEmpty: [
		self refreshSelectionFromEvent: anEvent.
		^ self ].

	target isAttachedToSceneGraph ifFalse: [
		self differUpdateSelectionFrom: target.
		^ self ].
	selectionGroupHolder updateSelectionIn: target
]
