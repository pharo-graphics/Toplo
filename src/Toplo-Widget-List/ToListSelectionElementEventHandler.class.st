Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> addNewSelectionElementsFrom: target [

	|  newSelElements |
	newSelElements := self newSelectionElementsFrom: target.
	target addChildren: newSelElements.

]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> differUpdateSelectionFrom: target [

	self subclassResponsibility 
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementScrolledEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToListSelectionElementEventHandler >> eventsToHandle [

	^ {
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent }
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> newSelectionElementsFrom: target [

	^ self subclassResponsibility 
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> previousSelectionElementsFrom: aTarget [

	^ self subclassResponsibility 
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> removePreviousSelectionElementsFrom: target [
	
	| previous |
	previous := self previousSelectionElementsFrom: target.
	previous do: [ :s | s removeFromParent ].

]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> selectionModelFrom: target [

	^ self subclassResponsibility
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	|  target  |
	target := anEvent currentTarget.
	target isAttachedToSceneGraph ifFalse: [
		self differUpdateSelectionFrom: target.
		^ self ].
	self removePreviousSelectionElementsFrom: target.
	(self selectionModelFrom: target) ifEmpty: [ ^ self ].
	self addNewSelectionElementsFrom: target.
]
