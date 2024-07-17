Class {
	#name : #ToListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToListElementWithDecoration',
	#classTraits : 'TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-List-Core-ListElement'
}

{ #category : #initialization }
ToListElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToListElement >> defaultInnerContainer [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToListElement >> defaultNodeManagerClass [

	^ ToListNodeManager  
]

{ #category : #'private - invalidation' }
ToListElement >> invalidateItemDecorations [

	self notifyPrimarySelectionDirty
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]
