Class {
	#name : #ToInfiniteDataSource,
	#superclass : #BlInfiniteDataSource,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #accessing }
ToInfiniteDataSource >> data [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToInfiniteDataSource >> data: aCollection [

	self subclassResponsibility 
]

{ #category : #accessing }
ToInfiniteDataSource >> dataAccessor [

	self subclassResponsibility 
]

{ #category : #accessing }
ToInfiniteDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self dataAccessor size
]

{ #category : #hooks }
ToInfiniteDataSource >> onAttached: anInfiniteElement [

	self dispatchEvent: ToDataSourceAttachedEvent new
	
]

{ #category : #'instance creation' }
ToInfiniteDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement newNodeHolderFromDataSource: self
]

{ #category : #hooks }
ToInfiniteDataSource >> onDetached: anInfiniteElement [

	self dispatchEvent: ToDataSourceDetachedEvent new
	
]
