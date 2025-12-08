Class {
	#name : #ToSpecificFiniteListElementForTest,
	#superclass : #ToAbstractFiniteListElement,
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #'t - finite list element - fake container' }
ToSpecificFiniteListElementForTest >> defaultFakeDataItem [

	^ 'Fake'
]

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> defaultNodeManagerClass [

	^ ToSpecificFiniteListNodeManagerForTest
]
