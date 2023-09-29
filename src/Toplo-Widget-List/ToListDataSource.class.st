Class {
	#name : #ToListDataSource,
	#superclass : #BlInfiniteDataSource,
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListDataSource >> data [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToListDataSource >> data: aCollection [

	self subclassResponsibility 
]

{ #category : #accessing }
ToListDataSource >> list [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToListDataSource >> list: aCollection [

	self subclassResponsibility 
]

{ #category : #'instance creation' }
ToListDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement newElementHolderFromDataSource: self
]

{ #category : #'instance creation' }
ToListDataSource >> onElementAttached: anElementHolder [

	super onElementAttached: anElementHolder.
	anElementHolder onAttachedFromDatasource: self
]

{ #category : #'instance creation' }
ToListDataSource >> onElementDetached: anElementHolder [
	
	super onElementDetached: anElementHolder.
	anElementHolder onDetachedFromDatasource: self
]
