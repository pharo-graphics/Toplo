Class {
	#name : #ToListDataSource,
	#superclass : #BlInfiniteDataSource,
	#category : #'Toplo-Widget-List-Infinite'
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

	^ anInfiniteElement newListNodeHolderFromDataSource: self
]
