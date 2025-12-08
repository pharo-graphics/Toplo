Class {
	#name : #ToItemFiniteListElementForTest,
	#superclass : #ToItemFiniteListElement,
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #'t - finite list element - fake container' }
ToItemFiniteListElementForTest >> defaultFakeDataItem [

	^ ToItemElementForTest new text: 'X'
]

{ #category : #initialization }
ToItemFiniteListElementForTest >> defaultNodeManagerClass [

	^ ToItemNodeManagerForTest
]
