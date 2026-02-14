Class {
	#name : #ToListElementWithFakeNodeContainerForTest,
	#superclass : #ToBasicListElement,
	#traits : 'TToListFakeNodeUser',
	#classTraits : 'TToListFakeNodeUser classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #initialization }
ToListElementWithFakeNodeContainerForTest >> defaultNodeManagerClass [

	^ ToListNodeManagerForTest
]
