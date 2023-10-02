Class {
	#name : #ToCheckNode,
	#superclass : #ToLabeledNode,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-List-node'
}

{ #category : #'t - list node - initialization' }
ToCheckNode >> defaultEventHandler [

	^ ToCheckNodeEventHandler new
]
