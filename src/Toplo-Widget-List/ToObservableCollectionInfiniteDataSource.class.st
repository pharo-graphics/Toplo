Class {
	#name : #ToObservableCollectionInfiniteDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'data',
		'infiniteElementSharedHandler',
		'observableCollectionEventHandler'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #accessing }
ToObservableCollectionInfiniteDataSource >> data [

	^ data
]

{ #category : #initialization }
ToObservableCollectionInfiniteDataSource >> initialize [ 

	super initialize.
	data := ToObservableCollection new.

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

	self flag: 'TODO: review ObservableCollection event handling to remove all #whenXXXChangedDo: '.

	observableCollectionEventHandler := ToObservableCollectionInfiniteEventHandler new.
	observableCollectionEventHandler infinite: anInfiniteElement.
	data addEventHandler: observableCollectionEventHandler.
	
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
	data removeEventHandler: observableCollectionEventHandler.
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
