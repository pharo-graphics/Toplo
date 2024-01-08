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
ToInfiniteDataSource >> list [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToInfiniteDataSource >> list: aCollection [

	self subclassResponsibility 
]

{ #category : #'instance creation' }
ToInfiniteDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement newListNodeHolderFromDataSource: self
]
