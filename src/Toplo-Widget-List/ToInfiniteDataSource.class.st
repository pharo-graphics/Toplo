Class {
	#name : #ToInfiniteDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'infiniteElementSharedHandler'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #hooks }
ToInfiniteDataSource >> onAttached: anInfiniteElement [

	super onAttached: anInfiniteElement.

	infiniteElementSharedHandler := BlSharedEventDistributor new
		                     shareEvents: self sharedEvents;
		                     yourself.
	self addEventHandler: infiniteElementSharedHandler.
	anInfiniteElement addEventHandler: infiniteElementSharedHandler.

	self notifyChanged
]

{ #category : #'instance creation' }
ToInfiniteDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement newNodeHolderFromDataSource: self
]

{ #category : #hooks }
ToInfiniteDataSource >> onDetached: anInfiniteElement [

	self removeEventHandler: infiniteElementSharedHandler.
	anInfiniteElement removeEventHandler: infiniteElementSharedHandler.
	infiniteElementSharedHandler := nil.
	super onDetached: anInfiniteElement.


	
]

{ #category : #hooks }
ToInfiniteDataSource >> sharedEvents [

	^ {
		  BlInfiniteDataSourceItemRangeChanged.
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved }
]
