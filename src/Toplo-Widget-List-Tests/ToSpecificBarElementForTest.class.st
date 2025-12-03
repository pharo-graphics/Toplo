Class {
	#name : #ToSpecificBarElementForTest,
	#superclass : #ToAbstractListElement,
	#traits : 'TToConfigurableBarElement + TToBarElement',
	#classTraits : 'TToConfigurableBarElement classTrait + TToBarElement classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #initialization }
ToSpecificBarElementForTest >> defaultNodeManagerClass [

	^ ToSpecificBarNodeManagerForTest
]

{ #category : #initialization }
ToSpecificBarElementForTest >> initialize [ 

	super initialize.
	self initializeAsBarElement 
]
