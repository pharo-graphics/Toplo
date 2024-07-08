Class {
	#name : #ToListSecondarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'previousNode'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'element handlers' }
ToListSecondarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	super elementScrolledEvent: anEvent.
	anEvent currentTarget spaceDo: [ :sp | 
		sp mouseProcessor handleLastMouseMove ].

]

{ #category : #'api - accessing' }
ToListSecondarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
		  ToListSecondarySelectionChangedEvent.
		  BlMouseMoveEvent }
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
	childNode = previousNode ifTrue: [ ^ self ].
	previousNode := childNode.
	childNode ifNil: [
		target secondarySelecter deselectAll.
		^ self ].
	target secondarySelecter selectOnlyIndex: childNode holder position
]
