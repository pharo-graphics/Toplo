Class {
	#name : #ToListElementFilterEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dataFilter',
		'target'
	],
	#category : 'Toplo-Widget-List-Filter'
}

{ #category : #'data events handling' }
ToListElementFilterEventHandler >> collectionAddEvent: anEvent [

	self dataFilter ifNil: [ ^ self ].
	self dataFilter collectionAddEvent: anEvent
]

{ #category : #'data events handling' }
ToListElementFilterEventHandler >> collectionRemoveEvent: anEvent [

	self dataFilter ifNil: [ ^ self ].
	self dataFilter collectionRemoveEvent: anEvent
]

{ #category : #'data events handling' }
ToListElementFilterEventHandler >> collectionUpdateEvent: anEvent [

	self dataFilter ifNil: [ ^ self ].
	self dataFilter collectionUpdateEvent: anEvent
]

{ #category : #accessing }
ToListElementFilterEventHandler >> dataFilter [

	^ dataFilter
]

{ #category : #accessing }
ToListElementFilterEventHandler >> dataFilter: aDataFilter [

	dataFilter = aDataFilter ifTrue: [ ^ self ].
	(dataFilter notNil and: [ target notNil ]) ifTrue: [
		dataFilter onUninstalledIn: target ].
	dataFilter := aDataFilter.
	(dataFilter notNil and: [ target notNil ]) ifTrue: [
		dataFilter onInstalledIn: target ]
]

{ #category : #'data events handling' }
ToListElementFilterEventHandler >> dataFilterRequest: anEvent [

	self dataFilter ifNil: [ ^ self ].
	self dataFilter dataFilterRequest: anEvent
]

{ #category : #'api - accessing' }
ToListElementFilterEventHandler >> eventsToHandle [

	^ {
		  " data (ToObservableCollection) events "
		  ToCollectionAddEvent.
		  ToCollectionRemoveEvent.
		  ToCollectionUpdateEvent.

		  " data source events "
		  ToDataFilterRequest }
]

{ #category : #'api - hooks' }
ToListElementFilterEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	(dataFilter notNil and: [ target notNil ]) ifTrue: [
		dataFilter onUninstalledIn: target ].
	target := anElement.
	(dataFilter notNil and: [ target notNil ]) ifTrue: [
		dataFilter onInstalledIn: target ]
]

{ #category : #'api - hooks' }
ToListElementFilterEventHandler >> onUninstalledIn: anElement [

	self dataFilter ifNotNil: [ :df | df onUninstalledIn: target ].
	target := nil.
	super onUninstalledIn: anElement.

]
