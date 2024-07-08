Class {
	#name : #ToListBasicAdditionalSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'selectionChangedEventClass'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListBasicAdditionalSelectionElementEventHandler class >> selectionMode: aSelectionMode selectionChangedEventClass: anEventClass [

	^ (self selectionMode: aSelectionMode)
		  selectionChangedEventClass: anEventClass;
		  yourself
]

{ #category : #'api - accessing' }
ToListBasicAdditionalSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { selectionChangedEventClass }
]

{ #category : #'api - event managing' }
ToListBasicAdditionalSelectionElementEventHandler >> handleEvent: anEvent [

	(anEvent isKindOf: selectionChangedEventClass)
		ifTrue: [
			self listAdditionalSelectionChangedEvent: anEvent.
			^ self ].
	anEvent sendTo: self
]

{ #category : #'element handlers' }
ToListBasicAdditionalSelectionElementEventHandler >> listAdditionalSelectionChangedEvent: anEvent [

	| touchedIntervals target |
	touchedIntervals := anEvent touchedIntervals.
	target := anEvent currentTarget.

	self refreshSelectionFromEvent: anEvent.

	touchedIntervals do: [ :int |
		target dataSource notifyItemsChanged: int ]
]

{ #category : #accessing }
ToListBasicAdditionalSelectionElementEventHandler >> selectionChangedEventClass: anEventClass [

	selectionChangedEventClass := anEventClass
]

{ #category : #'api - event managing' }
ToListBasicAdditionalSelectionElementEventHandler >> wantsEvent: anEvent [

	^ (anEvent isKindOf: selectionChangedEventClass) or: [
		  super wantsEvent: anEvent ]
]
