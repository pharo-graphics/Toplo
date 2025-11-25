Class {
	#name : #ToGenericListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListNodeManager >> initialize [

	super initialize.
	self initializeAsGenericNodeManager 
]

{ #category : #'instance creation' }
ToGenericListNodeManager >> newNodeContainer [ 

	^ ToListNodeContainer new
]

{ #category : #'instance creation' }
ToGenericListNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]

{ #category : #'t - generic node manager' }
ToGenericListNodeManager >> unbuildNode: aNode [

	nodeUnbuilder cull: aNode cull: aNode holder dataItem cull: aNode holder
]
