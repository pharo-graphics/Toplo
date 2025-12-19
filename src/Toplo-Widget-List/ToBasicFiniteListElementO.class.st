Class {
	#name : #ToBasicFiniteListElementO,
	#superclass : #ToBasicListElement,
	#traits : 'TToFiniteListElement + TToConfigurableFiniteListElement',
	#classTraits : 'TToFiniteListElement classTrait + TToConfigurableFiniteListElement classTrait',
	#instVars : [
		'uniformNodeWidth',
		'uniformNodeHeight',
		'autoDistribute',
		'isFlowable',
		'isScrollable'
	],
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #initialization }
ToBasicFiniteListElementO >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeContainerFactory: [ ToFiniteListNodeContainer new ];
		  yourself
]

{ #category : #initialization }
ToBasicFiniteListElementO >> initialize [

	super initialize.
	self initializeAsFiniteListElement.

]
