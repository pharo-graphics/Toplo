Class {
	#name : #ToListElementWithFakeNodeContainerForTest,
	#superclass : #ToBasicListElement,
	#traits : 'TToListFakeNodeUser',
	#classTraits : 'TToListFakeNodeUser classTrait',
	#category : #'Toplo-Widget-Tests-List'
}

{ #category : #initialization }
ToListElementWithFakeNodeContainerForTest >> defaultNodeManagerClass [

	^ ToListNodeManagerForTest
]
