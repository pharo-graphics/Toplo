Class {
	#name : #ToLinearBarElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToLinearBarElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToLinearBarElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToLinearBarElement >> defaultNodeContainer [

	^ ToInnerLinearBarElement onLinearBarElement: self
]
