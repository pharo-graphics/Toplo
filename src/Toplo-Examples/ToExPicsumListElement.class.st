Class {
	#name : #ToExPicsumListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Examples-PhotoGalleryParts'
}

{ #category : #initialization }
ToExPicsumListElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToExPicsumListElement >> defaultNodeManagerClass [

	^ ToExPicsumNodeManager
]
