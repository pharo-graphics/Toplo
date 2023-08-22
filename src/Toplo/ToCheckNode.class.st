Class {
	#name : #ToCheckNode,
	#superclass : #ToLabeledNode,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Core-Node'
}

{ #category : #'t - initialization dresser' }
ToCheckNode >> defaultDresser [ 

	^ ToCheckNodeDresser new
]

{ #category : #'as yet unclassified' }
ToCheckNode >> initialize [

	super initialize.
	self initializeCheckable 
]
