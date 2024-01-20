Class {
	#name : #ToSelectFiltrableListEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'element handlers' }
ToSelectFiltrableListEventHandler >> collectionFilteredEvent: anEvent [

	select currentWindow ifNil: [
		select strategy textInputElement filterString ifNotEmpty: [
			select popupWindowEvent: anEvent ] ]
]

{ #category : #'api - accessing' }
ToSelectFiltrableListEventHandler >> eventsToHandle [

	^ { ToFilteredListSelectionChangedEvent. ToCollectionFilteredEvent }
]

{ #category : #'element handlers' }
ToSelectFiltrableListEventHandler >> filteredListSelectionChangedEvent: anEvent [

	select strategy refreshHeaderNodeContainer
]

{ #category : #accessing }
ToSelectFiltrableListEventHandler >> select: aSelect [

	select := aSelect
]
