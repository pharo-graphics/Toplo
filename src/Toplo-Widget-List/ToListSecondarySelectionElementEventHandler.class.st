Class {
	#name : #ToListSecondarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> differUpdateSelectionFrom: anElement [
]

{ #category : #'element handlers' }
ToListSecondarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | 
		sp mouseProcessor handleLastMouseMove ].
	super elementScrolledEvent: anEvent
]

{ #category : #'api - accessing' }
ToListSecondarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
		  ToInfiniteScrollFinishedEvent.
		  ToListSecondarySelectionChangedEvent.
		  BlMouseMoveEvent }
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> infiniteScrollFinishedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> listSecondarySelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> mouseMoveEvent: anEvent [

	| target nodeContainer globalPosition childNode |
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	target := anEvent currentTarget.
	nodeContainer := target innerContainer.
	globalPosition := anEvent position.

	childNode := nodeContainer selectableNodeContainingGlobalPosition: globalPosition.
	childNode ifNil: [
		target secondarySelecter deselectAll.
		^ self ].
	target secondarySelecter selectOnlyIndex: childNode holder position
]

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> previousSelectionElementsFrom: aTarget [
	
	^ aTarget secondarySelectionElements
]

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> selectionElementClassFrom: aTarget [

	^ aTarget secondarySelectionMode elementClass
]

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> selectionModeFrom: aTarget [

	^ aTarget secondarySelectionMode
]

{ #category : #'selection managing' }
ToListSecondarySelectionElementEventHandler >> selectionModelFrom: target [

	^ target secondarySelectionModel
]
