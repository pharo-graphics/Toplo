Class {
	#name : #ToListInfiniteElement,
	#superclass : #ToInfiniteElement,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #initialization }
ToListInfiniteElement >> defaultDataSource [

	^ ToListObservableCollectionDataSource new
]

{ #category : #initialization }
ToListInfiniteElement >> holderClass [

	^ ToListNodeHolder 
]

{ #category : #skin }
ToListInfiniteElement >> newRawSkin [

	^ ToListInfiniteElementSkin new
]
