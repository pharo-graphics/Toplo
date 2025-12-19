Class {
	#name : #ToBasicWrappedListElement,
	#superclass : #ToBasicListElement,
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #initialization }
ToBasicWrappedListElement >> defaultDataAccessor [

	^ ToWrappedListDataAccessor new 
]

{ #category : #initialization }
ToBasicWrappedListElement >> defaultNodeManagerClass [

	^ ToWrappedListNodeManager
]

{ #category : #initialization }
ToBasicWrappedListElement >> initializeDataAccessor [

	dataAccessor := self defaultDataAccessor listElement: self
]

{ #category : #initialization }
ToBasicWrappedListElement >> initializeDataSource [

	super initializeDataSource.
	dataSource
		addEventHandlerOn: ToAbstractCollectionChangedEvent
		do: [ :event | self dataAccessor dispatchEvent: event copy ]
]

{ #category : #'instance creation' }
ToBasicWrappedListElement >> sieveClass [

	^ ToWrappedListElementSieve
]
