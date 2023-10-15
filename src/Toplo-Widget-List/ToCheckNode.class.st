Class {
	#name : 'ToCheckNode',
	#superclass : 'ToLabeledNode',
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : 'Toplo-Widget-List-node',
	#package : 'Toplo-Widget-List',
	#tag : 'node'
}

{ #category : 'testing' }
ToCheckNode class >> isDeprecated [ 

	^ true
]

{ #category : 't - list node - initialization' }
ToCheckNode >> defaultEventHandler [

	^ ToCheckNodeEventHandler new
]
