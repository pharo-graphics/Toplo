Class {
	#name : #ToSpecificBarElementForTest,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #initialization }
ToSpecificBarElementForTest >> defaultNodeManagerClass [

	^ ToSpecificBarNodeManagerForTest
]
