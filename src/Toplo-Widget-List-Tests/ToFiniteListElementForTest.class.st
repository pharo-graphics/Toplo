Class {
	#name : #ToFiniteListElementForTest,
	#superclass : #ToBasicListElement,
	#traits : 'TToFiniteListElement',
	#classTraits : 'TToFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #'fake container' }
ToFiniteListElementForTest >> defaultFakeDataItem [

	^ 'Fake'
]

{ #category : #initialization }
ToFiniteListElementForTest >> defaultNodeManagerClass [

	^ ToListNodeManagerForTest
]

{ #category : #initialization }
ToFiniteListElementForTest >> defaultUseInfiniteLayout [ 

	^ false
]

{ #category : #initialization }
ToFiniteListElementForTest >> initialize [ 

	super initialize.
	self fakeDataItem: 'Fake'
]
