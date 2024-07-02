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

{ #category : #'selection managing' }
ToListBasicAdditionalSelectionElementEventHandler >> differUpdateSelectionFrom: target [
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

	self refreshSelectionFromEvent: anEvent.
	self flag: 'To check because notifying change to the data source is time consuming'.
	anEvent currentTarget dataSource notifyChanged.
	self flag: 'Normaly, notifying change to the only concerned items should be enough'.
	"anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		anEvent currentTarget dataSource notifyItemsChanged:
			(interval first to: interval last) ]"
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
