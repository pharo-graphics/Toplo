Class {
	#name : #ToInfiniteObservableCollectionDataSource,
	#superclass : #ToInfiniteDataSource,
	#instVars : [
		'data',
		'observableCollectionEventHandler',
		'infiniteSharedHandler'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #accessing }
ToInfiniteObservableCollectionDataSource >> data [

	^ data
]

{ #category : #accessing }
ToInfiniteObservableCollectionDataSource >> data: anObservableCollection [


	data := anObservableCollection.

	data whenAddChangeDo: [ :ann |
		self notifyItemsInserted: ann interval ].
	data whenRemoveChangeDo: [ :ann |
		self notifyItemsRemoved: ann interval ].
	data whenUpdateChangeDo: [ :ann |
		self notifyItemsChanged: ann interval ].
	data whenBeforeFilterChangeDo: [ :ann |
		self notifyItemsRemoved: ann interval ].
	data whenFilterChangeDo: [ :ann |
		self notifyItemsInserted: ann interval ].

	self notifyChanged
]

{ #category : #accessing }
ToInfiniteObservableCollectionDataSource >> dataAccessor [

	^ self data
]

{ #category : #initialization }
ToInfiniteObservableCollectionDataSource >> initialize [ 

	super initialize.
	self data: ToObservableCollection new.

]

{ #category : #hooks }
ToInfiniteObservableCollectionDataSource >> onAttached: anInfiniteElement [

	" prepare the event handler for the data observable collection "
	observableCollectionEventHandler := ToInfiniteObservableCollectionEventHandler new.
	observableCollectionEventHandler infinite: anInfiniteElement.
	data addEventHandler: observableCollectionEventHandler.
	
	infiniteSharedHandler := BlSharedEventDistributor new
		                     shareEvents: anInfiniteElement dataSourceSharedEvents;
		                     yourself.
	self addEventHandler: infiniteSharedHandler.
	anInfiniteElement addEventHandler: infiniteSharedHandler.
	super onAttached: anInfiniteElement
]

{ #category : #'instance creation' }
ToInfiniteObservableCollectionDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"

	anElementHolder dataItem: (self dataAccessor at: aPosition)
]

{ #category : #hooks }
ToInfiniteObservableCollectionDataSource >> onDetached: anInfiniteElement [

	data removeEventHandler: observableCollectionEventHandler.
	anInfiniteElement removeEventHandler: infiniteSharedHandler.
	self removeEventHandler: infiniteSharedHandler.

	observableCollectionEventHandler := nil.
	infiniteSharedHandler := nil.
	super onDetached: anInfiniteElement
]
