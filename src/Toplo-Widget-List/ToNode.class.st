Class {
	#name : #ToNode,
	#superclass : #ToWidget,
	#traits : 'TToNode + TToClickable',
	#classTraits : 'TToNode classTrait + TToClickable classTrait',
	#category : #'Toplo-Widget-List-node'
}

{ #category : #'t - clickable - click behavior' }
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
