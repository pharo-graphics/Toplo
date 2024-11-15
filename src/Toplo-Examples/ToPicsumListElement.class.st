Class {
	#name : #ToPicsumListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Examples-PhotoGalleryParts'
}

{ #category : #initialization }
ToPicsumListElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToPicsumListElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToPicsumListElement >> defaultNodeManagerClass [

	^ ToPicsumNodeManager  
]
