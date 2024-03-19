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

{ #category : #accessing }
ToObservableCollectionInfiniteDataSource >> data [

	^ data
]

{ #category : #initialization }
ToObservableCollectionInfiniteDataSource >> initialize [ 

	super initialize.
	"data := ToProtectedCollection new"
	data := OrderedCollection new

]

{ #category : #accessing }
ToObservableCollectionInfiniteDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self data size
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

	anElementHolder bindDataItem: (self data at: aPosition)
]

{ #category : #hooks }
ToObservableCollectionInfiniteDataSource >> onDetached: anInfiniteElement [

	self data removeEventHandler: dataEventHandler.
	super onDetached: anInfiniteElement.


	
]

{ #category : #'t - observable collection - copying' }
ToObservableCollectionInfiniteDataSource >> postCopy [

	data := self collection copy
]

{ #category : #hooks }
ToObservableCollectionInfiniteDataSource >> sharedEvents [

	^ super sharedEvents , {
		  ToObservableCollectionEvent }
]
