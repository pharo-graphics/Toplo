Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> collectionFilteredEvent: anEvent [

	select currentWindow ifNil: [
		select textInputElement filterString ifNotEmpty: [
			select popupWindowEvent: anEvent ] ]
]

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ {
		  ToCollectionFilteredEvent.
		  ToSieveSelectionChangedEvent.
		  ToSelectGroupSelectionChangedEvent }
]

{ #category : #accessing }
ToSelectListElementEventHandler >> select: aSelect [

	select := aSelect
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> selectGroupSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	(select selectionModel subSelectionModelWithId: #group)
		copySelectionFrom: anEvent selectionModel
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	select onSelectionChangedInListElement
]
