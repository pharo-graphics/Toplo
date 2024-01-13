Class {
	#name : #ToSelectListEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'api - accessing' }
ToSelectListEventHandler >> eventsToHandle [

	^ { ToFilteredListSelectionChangedEvent }
]

{ #category : #'element handlers' }
ToSelectListEventHandler >> filteredListSelectionChangedEvent: anEvent [

	select refreshNodes
]

{ #category : #'element handlers' }
ToSelectListEventHandler >> listDeselectIndexEvent: anEvent [

	select refreshNodes
]

{ #category : #'element handlers' }
ToSelectListEventHandler >> listSelectIndexEvent: anEvent [

	select refreshNodes.
]

{ #category : #accessing }
ToSelectListEventHandler >> select: aSelect [

	select := aSelect
]
