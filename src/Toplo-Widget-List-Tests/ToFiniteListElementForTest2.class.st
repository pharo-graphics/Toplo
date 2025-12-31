Class {
	#name : #ToFiniteListElementForTest2,
	#superclass : #ToBasicListElement,
	#traits : 'TToFiniteListElement',
	#classTraits : 'TToFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #'fake container' }
ToFiniteListElementForTest2 >> defaultFakeDataItem [

	^ ToLabel text: 'Fake'
]

{ #category : #initialization }
ToFiniteListElementForTest2 >> defaultNodeManagerClass [

	^ ToListNodeManagerForTest2
]

{ #category : #initialization }
ToFiniteListElementForTest2 >> defaultUseInfiniteLayout [ 

	^ false
]

{ #category : #initialization }
ToFiniteListElementForTest2 >> initialize [ 

	| lab |
	super initialize.
	lab := ToLabel text: 'Fake'.
	self fakeDataItem: lab
]
