Class {
	#name : #ToCheckNode,
	#superclass : #ToLabeledNode,
	#traits : 'TToCheckable + TToCheckableWithIndeterminate',
	#classTraits : 'TToCheckable classTrait + TToCheckableWithIndeterminate classTrait',
	#category : #'Toplo-Core-Node'
}

{ #category : #'t - initialization dresser' }
ToCheckNode >> defaultDresser [ 

	^ ToCheckNodeDresser new
]

{ #category : #'as yet unclassified' }
ToCheckNode >> deselectedInInfiniteElement [

	self uncheck
]

{ #category : #'as yet unclassified' }
ToCheckNode >> selectedInInfiniteElement [

	self check
]
