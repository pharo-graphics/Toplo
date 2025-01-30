Class {
	#name : #ToGenericListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListNodeManager >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		| l |
		l := aNode holder listElement.
		l isHorizontal
			ifTrue: [ c horizontal fitContent ]
			ifFalse: [ c horizontal matchParent ].
		c vertical fitContent ]
]

{ #category : #initialization }
ToGenericListNodeManager >> initialize [

	super initialize.
	self initializeAsGenericNodeManager 
]

{ #category : #'t - generic node manager' }
ToGenericListNodeManager >> newHolder [

	^ ToNodeHolder new
]
