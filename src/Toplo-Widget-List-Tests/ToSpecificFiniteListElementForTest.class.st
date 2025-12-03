Class {
	#name : #ToSpecificFiniteListElementForTest,
	#superclass : #ToAbstractListElement,
	#traits : 'TToConfigurableBarElement + TToFiniteListElement',
	#classTraits : 'TToConfigurableBarElement classTrait + TToFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> defaultNodeManagerClass [

	^ ToSpecificFiniteListNodeManagerForTest
]

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> initialize [ 

	super initialize.
	self initializeAsBarElement 
]
