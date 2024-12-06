Class {
	#name : #ToListElement,
	#superclass : #ToGenericListElement,
	#traits : 'TToListElementWithDecoration',
	#classTraits : 'TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-List-Core-ListElement'
}

{ #category : #initialization }
ToListElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToListElement >> defaultNodeManagerClass [

	^ ToGenericListNodeManager  
]

{ #category : #'private - invalidation' }
ToListElement >> invalidateItemDecorations [

	self updateAllSelections
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]
