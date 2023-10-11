Class {
	#name : #ToNode,
	#superclass : #ToElement,
	#traits : 'TToNode + TToClickable',
	#classTraits : 'TToNode classTrait + TToClickable classTrait',
	#category : #'Toplo-Widget-List-node'
}

{ #category : #'as yet unclassified' }
ToNode >> client [

	^ self  
]

{ #category : #'t - list node - initialization' }
ToNode >> defaultEventHandler [

	^ ToNodeEventHandler new
]

{ #category : #initialization }
ToNode >> initialize [

	super initialize.
	self initializeListNode

]
