Class {
	#name : #ToInfiniteCollectionDataSource,
	#superclass : #ToInfiniteDataSource,
	#traits : 'TToObservableCollection',
	#classTraits : 'TToObservableCollection classTrait',
	#instVars : [
		'dataEventHandler',
		'data'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #accessing }
ToInfiniteCollectionDataSource >> collection [

	^ data

]

{ #category : #accessing }
ToInfiniteCollectionDataSource >> dataAccessor [

	^ self
]

{ #category : #initialization }
ToInfiniteCollectionDataSource >> initialize [ 

	super initialize.
	data := OrderedCollection new
]

{ #category : #accessing }
ToInfiniteCollectionDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self size
]

{ #category : #hooks }
ToInfiniteCollectionDataSource >> onAttached: anInfiniteElement [

	super onAttached: anInfiniteElement.
	dataEventHandler := ToInfiniteDataSourceDataEventHandler new.
	dataEventHandler infinite: anInfiniteElement.
	self addEventHandler: dataEventHandler
]

{ #category : #'instance creation' }
ToInfiniteCollectionDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"

	anElementHolder bindDataItem: (self at: aPosition)
]

{ #category : #hooks }
ToInfiniteCollectionDataSource >> onDetached: anInfiniteElement [

	self removeEventHandler: dataEventHandler.
	super onDetached: anInfiniteElement.


	
]

{ #category : #hooks }
ToInfiniteCollectionDataSource >> sharedEvents [

	^ super sharedEvents , {
		  ToObservableCollectionEvent }
]
