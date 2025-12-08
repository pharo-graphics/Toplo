Class {
	#name : #ToSpecificFiniteListElementForTest2,
	#superclass : #ToSpecificFiniteListElementForTest,
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #'t - finite list element - fake container' }
ToSpecificFiniteListElementForTest2 >> defaultFakeDataItem [

	^ ToLabel text: 'Fake'
]

{ #category : #initialization }
ToSpecificFiniteListElementForTest2 >> defaultNodeManagerClass [

	^ ToSpecificFiniteListNodeManagerForTest2
]
