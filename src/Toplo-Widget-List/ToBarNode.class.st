Class {
	#name : #ToBarNode,
	#superclass : #ToListNode,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToBarNode >> initialize [ 

	super initialize.
	self initializeForToplo 
]

{ #category : #skin }
ToBarNode >> newRawSkin [ 

	^ ToBarNodeSkin new
]
