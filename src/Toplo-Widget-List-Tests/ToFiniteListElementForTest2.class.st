Class {
	#name : #ToFiniteListElementForTest2,
	#superclass : #ToBasicListElement,
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToFiniteListElementForTest2 >> defaultInnerElementClass [

	^ ToScrollableFiniteListElement
]

{ #category : #initialization }
ToFiniteListElementForTest2 >> defaultNodeManagerClass [

	^ ToListNodeManagerForTest2
]
