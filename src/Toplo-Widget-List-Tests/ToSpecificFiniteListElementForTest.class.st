Class {
	#name : #ToSpecificFiniteListElementForTest,
	#superclass : #ToBasicListElement,
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #'t - finite list element - fake container' }
ToSpecificFiniteListElementForTest >> defaultFakeDataItem [

	^ 'Fake'
]

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> defaultInnerElementClass [ 

	^ ToInnerFiniteListElement
]

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> defaultNodeManagerClass [

	^ ToSpecificFiniteListNodeManagerForTest
]

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> initialize [ 

	super initialize.
	useInfiniteLayout := false.
	self fakeDataItem: 'Fake'
]
