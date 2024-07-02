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

	| touchedIndexes target |
	touchedIndexes := anEvent touchedIndexes.
	target := anEvent currentTarget.

	self refreshSelectionFromEvent: anEvent.

	touchedIndexes size >= (target nodes size)
		ifTrue: [ target notifyDataSourceChanged ]
		ifFalse: [
			touchedIndexes do: [ :idx |
				target dataSource notifyItemsChanged: (idx to: idx) ] ]
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
