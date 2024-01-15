Class {
	#name : #ToSelectListEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'element handlers' }
ToSelectListEventHandler >> collectionFilteredEvent: anEvent [

	select currentWindow ifNil: [
		select mode filterString ifNotEmpty: [
			select popupEvent: anEvent ] ]
]

{ #category : #'api - accessing' }
ToSelectListEventHandler >> eventsToHandle [

	^ { ToFilteredListSelectionChangedEvent. ToCollectionFilteredEvent }
]

{ #category : #'element handlers' }
ToSelectListEventHandler >> filteredListSelectionChangedEvent: anEvent [

	select strategy refreshNodeContainer
]

{ #category : #accessing }
ToSelectListEventHandler >> select: aSelect [

	select := aSelect
]
