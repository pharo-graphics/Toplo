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

{ #category : #testing }
ToListElement >> isMultipleSelection [

	^ self selectionMode isMultipleSelection
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]
