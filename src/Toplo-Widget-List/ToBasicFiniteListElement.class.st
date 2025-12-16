Class {
	#name : #ToBasicFiniteListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToFiniteListElement + TToConfigurableFiniteListElement',
	#classTraits : 'TToFiniteListElement classTrait + TToConfigurableFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #initialization }
ToBasicFiniteListElement >> defaultNodeManagerClass [ 

	^ ToFiniteListNodeManager
]

{ #category : #initialization }
ToBasicFiniteListElement >> initialize [

	super initialize.
	self initializeAsFiniteListElement.

]
