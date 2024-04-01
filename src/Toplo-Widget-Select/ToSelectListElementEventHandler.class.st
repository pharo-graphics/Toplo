Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ { ToSieveSelectionChangedEvent. ToSelectGroupSelectionChangedEvent  }
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
	select notifySelectionChanged
]
