Class {
	#name : #ToLabeledNode,
	#superclass : #ToPairedNode,
	#traits : 'TToLabeledIcon',
	#classTraits : 'TToLabeledIcon classTrait',
	#category : #'Toplo-Core-Node'
}

{ #category : #'t - initialization dresser' }
ToLabeledNode >> defaultDresser [ 

	^ ToLabeledNodeDresser new
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeEditable [

	self label ifNotNil: [ :l | l beEditable ]
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeReadOnly [ 

	self label ifNotNil: [ :l | l beReadOnly ]
]
