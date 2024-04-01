Class {
	#name : #ToInfiniteCollectionDataSource,
	#superclass : #ToInfiniteDataSource,
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
ToInfiniteCollectionDataSource >> data [

	^ data
]

{ #category : #accessing }
ToInfiniteCollectionDataSource >> dataAccessor [

	^ data
]

{ #category : #initialization }
ToInfiniteCollectionDataSource >> initialize [ 

	super initialize.
	data := ToObservableCollection new
]

{ #category : #accessing }
ToInfiniteCollectionDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self data size
]

{ #category : #hooks }
ToInfiniteCollectionDataSource >> onAttached: anInfiniteElement [

	super onAttached: anInfiniteElement.
	dataEventHandler := ToInfiniteDataSourceDataEventHandler new.
	dataEventHandler infinite: anInfiniteElement.
	self data addEventHandler: dataEventHandler
]

{ #category : #'instance creation' }
ToInfiniteCollectionDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"

	anElementHolder bindDataItem: (self data at: aPosition)
]

{ #category : #hooks }
ToInfiniteCollectionDataSource >> onDetached: anInfiniteElement [

	self data removeEventHandler: dataEventHandler.
	super onDetached: anInfiniteElement.


	
]

{ #category : #hooks }
ToInfiniteCollectionDataSource >> sharedEvents [

	^ super sharedEvents , {
		  ToInfiniteDataSourceEmptinessChangedEvent.
		  ToObservableCollectionEvent }
]
