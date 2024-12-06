Class {
	#name : #ToSpecificListElementForTest,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #'as yet unclassified' }
ToSpecificListElementForTest >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToSpecificListElementForTest >> defaultNodeManagerClass [

	^ ToSpecificListNodeManagerForTest
]
