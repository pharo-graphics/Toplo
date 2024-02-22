Class {
	#name : #ToObservableCollectionInfiniteDataSource,
	#superclass : #ToInfiniteDataSource,
	#traits : 'TToObservableCollection',
	#classTraits : 'TToObservableCollection classTrait',
	#instVars : [
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
	dataEventHandler := ToInfiniteDataSourceDataEventHandler new.
	dataEventHandler infinite: anInfiniteElement.
	self addEventHandler: dataEventHandler
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

	data removeEventHandler: dataEventHandler.
	super onDetached: anInfiniteElement.


	
]

{ #category : #hooks }
ToObservableCollectionInfiniteDataSource >> sharedEvents [

	^ super sharedEvents , {
		  ToObservableCollectionEvent }
]