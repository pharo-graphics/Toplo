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

	^ { ToListElementSieveSelectionChangedEvent. ToCollectionFilteredEvent }
]

{ #category : #'element handlers' }
ToSelectFiltrableListEventHandler >> listElementSieveSelectionChangedEvent: anEvent [

	select selection indices = anEvent selection indices ifTrue: [ ^ self ].
	select selection deselectAll.
	select selection selectAllIndexes: anEvent selection indices.
	select strategy refreshHeaderNodeContainer.

]

{ #category : #accessing }
ToSelectFiltrableListEventHandler >> select: aSelect [

	select := aSelect
]
