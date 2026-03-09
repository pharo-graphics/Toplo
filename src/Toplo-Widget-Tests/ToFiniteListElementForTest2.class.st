Class {
	#name : #ToFiniteListElementForTest2,
	#superclass : #ToBasicListElement,
	#category : #'Toplo-Widget-Tests-List'
}

{ #category : #initialization }
ToFiniteListElementForTest2 >> defaultInnerElementClass [

	^ ToScrollableFiniteListElement
]

{ #category : #initialization }
ToFiniteListElementForTest2 >> defaultNodeManagerClass [

	^ ToListNodeManagerForTest2
]
