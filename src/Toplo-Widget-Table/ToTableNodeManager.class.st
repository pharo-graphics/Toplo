Class {
	#name : #ToTableNodeManager,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#instVars : [
		'columns'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableNodeManager >> buildNode: aTableNode [

	self columns do: [ :column |
			aTableNode
				addChild: (column render: aTableNode holder dataItem)
				in: column key ]
]

{ #category : #accessing }
ToTableNodeManager >> columns [

	^ columns
]

{ #category : #accessing }
ToTableNodeManager >> columns: anObject [

	columns := anObject
]

{ #category : #'t - generic node manager' }
ToTableNodeManager >> defaultNodeFactory [

	^ [ :holder | ToTableNode withColumns: self columns ]
]

{ #category : #initialization }
ToTableNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager.
]

{ #category : #'instance creation' }
ToTableNodeManager >> newHolder [

	^ ToTableNodeHolder new
]

{ #category : #'instance creation' }
ToTableNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]
