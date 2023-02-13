Class {
	#name : #ToListDataSource,
	#superclass : #OBlInfiniteDataSource,
	#category : #'Toplo-Widget-List'
}

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

	^ anInfiniteElement holderClass new infiniteElement: anInfiniteElement 
]

{ #category : #'instance creation' }
ToListDataSource >> onElementAttached: anElementHolder [

	super onElementAttached: anElementHolder.
	anElementHolder onAttachedFromDatasource: self.

]

{ #category : #'instance creation' }
ToListDataSource >> onElementDetached: anElementHolder [
	
	super onElementDetached: anElementHolder.
	anElementHolder onDetachedFromDatasource: self.
	anElementHolder unsubscribe: self
]
