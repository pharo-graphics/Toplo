Class {
	#name : #ToNode,
	#superclass : #ToElement,
	#traits : 'TToNode + TToClickable',
	#classTraits : 'TToNode classTrait + TToClickable classTrait',
	#category : #'Toplo-Widget-List-node'
}

{ #category : #'t - list node - initialization' }
ToNode >> defaultEventHandler [

	^ ToNodeEventHandler new
]

{ #category : #initialization }
ToNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToNode >> initialize [

	super initialize.
	self initializeListNode

]
