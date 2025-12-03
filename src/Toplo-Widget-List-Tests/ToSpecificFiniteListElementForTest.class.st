Class {
	#name : #ToSpecificFiniteListElementForTest,
	#superclass : #ToAbstractListElement,
	#traits : 'TToConfigurableBarElement + TToFiniteListElement',
	#classTraits : 'TToConfigurableBarElement classTrait + TToFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> defaultNodeManagerClass [

	^ ToSpecificBarNodeManagerForTest
]

{ #category : #initialization }
ToSpecificFiniteListElementForTest >> initialize [ 

	super initialize.
	self initializeAsBarElement 
]
