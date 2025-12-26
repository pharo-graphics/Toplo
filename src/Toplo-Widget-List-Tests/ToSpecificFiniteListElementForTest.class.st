Class {
	#name : #ToSpecificFiniteListElementForTest,
	#superclass : #ToBasicListElement,
	#traits : 'TToFiniteListElement',
	#classTraits : 'TToFiniteListElement classTrait',
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

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> defaultUseInfiniteLayout [ 

	^ false
]

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> initialize [ 

	super initialize.
	self fakeDataItem: 'Fake'
]
