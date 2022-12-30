Class {
	#name : #ToListDataSource,
	#superclass : #ToInfiniteDataSource,
	#category : #'Toplo-Core-Infinite'
}

{ #category : #initialization }
ToListDataSource >> defaultElementHolderClass [
	
	^ ToListNodeHolder 

]
