Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> collectionFilteredEvent: anEvent [

	select isMultipleSelection ifFalse: [
		select listElement secondarySelectionModel deselectAll ]
]

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ {
		  ToSieveSelectionChangedEvent.
		  ToCollectionFilteredEvent }
]

{ #category : #accessing }
ToSelectListElementEventHandler >> select: aSelect [

	select := aSelect
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	select copySelectionFrom: anEvent selectionModel
]
