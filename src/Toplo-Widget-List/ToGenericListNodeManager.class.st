Class {
	#name : #ToGenericListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListNodeManager >> defaultNodeConstraintsHook [

	^ [ :node :dataItem :holder |
	  node constraintsDo: [ :c |
		  | l |
		  l := node holder listElement.
		  l isHorizontal
			  ifTrue: [ c horizontal fitContent ]
			  ifFalse: [ c horizontal matchParent ].
		  c vertical fitContent ] ]
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

{ #category : #'t - generic node manager' }
ToGenericListNodeManager >> unbuildNode: aNode [

	nodeUnbuilder cull: aNode cull: aNode holder dataItem cull: aNode holder
]
