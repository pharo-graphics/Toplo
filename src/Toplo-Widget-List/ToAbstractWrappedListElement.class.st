Class {
	#name : #ToAbstractWrappedListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #initialization }
ToAbstractWrappedListElement >> defaultDataAccessor [

	^ ToWrappedListDataAccessor new 
]

{ #category : #initialization }
ToAbstractWrappedListElement >> defaultNodeManagerClass [

	^ ToWrappedListNodeManager
]

{ #category : #initialization }
ToAbstractWrappedListElement >> initializeDataAccessor [

	dataAccessor := self defaultDataAccessor listElement: self
]

{ #category : #initialization }
ToAbstractWrappedListElement >> initializeDataSource [

	super initializeDataSource.
	dataSource
		addEventHandlerOn: ToAbstractCollectionChangedEvent
		do: [ :event | self dataAccessor dispatchEvent: event copy ]
]

{ #category : #'instance creation' }
ToAbstractWrappedListElement >> sieveClass [

	^ ToWrappedListElementSieve
]
