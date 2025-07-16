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
