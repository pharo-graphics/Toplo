Class {
	#name : #ToSelectSecondarySelectionElementEventHandler,
	#superclass : #ToListSecondarySelectionElementEventHandler,
	#instVars : [
		'lastSelectionChangedEvent'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'mouse handlers' }
ToSelectSecondarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	lastSelectionChangedEvent
		ifNil: [ super elementScrolledEvent: anEvent ]
		ifNotNil: [
		self updateSelectionFromEvent: lastSelectionChangedEvent ]
]

{ #category : #'mouse handlers' }
ToSelectSecondarySelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	super updateSelectionFromEvent: anEvent.
	lastSelectionChangedEvent := anEvent
]
