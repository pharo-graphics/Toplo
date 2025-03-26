Class {
	#name : #ToAbstractNodeManager,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToAbstractNodeManager >> applyNodeConstraintsOn: aNode [
]

{ #category : #initialization }
ToAbstractNodeManager >> buildNode: aNode [ 

]

{ #category : #initialization }
ToAbstractNodeManager >> constraintNode: aNode [

	self
		deprecated: 'Use #applyNodeConstraintsOn:'
		transformWith: '`@rcvr constraintNode: `@arg'
			-> '`@rcvr applyNodeConstraintsOn: `@arg'.
	self applyNodeConstraintsOn: aNode
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newHolder [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newNodeForHolder: aNodeHolder [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractNodeManager >> unbuildNode: aNode [


]
