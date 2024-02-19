Class {
	#name : #ToObservableCollectionInfiniteDataSource,
	#superclass : #BlInfiniteDataSource,
	#traits : 'TToObservableCollection',
	#classTraits : 'TToObservableCollection classTrait',
	#instVars : [
		'infiniteElementSharedHandler',
		'dataEventHandler',
		'data'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'t - observable collection - accessing' }
ToObservableCollectionInfiniteDataSource >> collection [

	^ data

]

{ #category : #'t - observable collection - accessing' }
ToObservableCollectionInfiniteDataSource >> collection: aCollection [

	data := aCollection
]

{ #category : #accessing }
ToObservableCollectionInfiniteDataSource >> data [

	^ data
]

{ #category : #initialization }
ToObservableCollectionInfiniteDataSource >> initialize [ 

	super initialize.
	data := OrderedCollection new

]

{ #category : #accessing }
ToObservableCollectionInfiniteDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ data size
]

{ #category : #hooks }
ToObservableCollectionInfiniteDataSource >> onAttached: anInfiniteElement [

	super onAttached: anInfiniteElement.

	infiniteElementSharedHandler := BlSharedEventDistributor new
		                     shareEvents: self sharedEvents;
		                     yourself.
	self addEventHandler: infiniteElementSharedHandler.
	anInfiniteElement addEventHandler: infiniteElementSharedHandler.

	dataEventHandler := ToInfiniteDataSourceDataEventHandler new.
	dataEventHandler infinite: anInfiniteElement.
	self addEventHandler: dataEventHandler.

	self notifyChanged.

	self dispatchEvent: ToDataSourceAttachedEvent new
	
]

{ #category : #'instance creation' }
ToObservableCollectionInfiniteDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"

	anElementHolder dataItem: (data at: aPosition)
]

{ #category : #'instance creation' }
ToObservableCollectionInfiniteDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement newNodeHolderFromDataSource: self
]

{ #category : #hooks }
ToObservableCollectionInfiniteDataSource >> onDetached: anInfiniteElement [

	super onDetached: anInfiniteElement.
	data removeEventHandler: dataEventHandler.
	self removeEventHandler: infiniteElementSharedHandler.
	anInfiniteElement removeEventHandler: infiniteElementSharedHandler.
	self dispatchEvent: ToDataSourceDetachedEvent new.
	infiniteElementSharedHandler := nil.

	
]

{ #category : #accessing }
ToObservableCollectionInfiniteDataSource >> sharedEvents [

	^ {
		  ToDataSourceAttachedEvent.
		  ToDataSourceDetachedEvent.
		  BlInfiniteDataSourceItemRangeChanged.
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved }
]
