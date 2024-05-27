Class {
	#name : #ToListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToListElementWithDecoration',
	#classTraits : 'TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToListElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToListElement >> defaultInnerNodeContainer [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToListElement >> defaultNodeManagerClass [

	^ ToListNodeManager  
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]
