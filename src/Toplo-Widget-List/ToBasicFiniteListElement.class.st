Class {
	#name : #ToBasicFiniteListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToFiniteListElement + TToConfigurableFiniteListElement',
	#classTraits : 'TToFiniteListElement classTrait + TToConfigurableFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #initialization }
ToBasicFiniteListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeContainerFactory: [ ToFiniteListNodeContainer new ];
		  yourself
]

{ #category : #initialization }
ToBasicFiniteListElement >> initialize [

	super initialize.
	self initializeAsFiniteListElement.

]
