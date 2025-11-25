Class {
	#name : #ToAbstractNodeManager,
	#superclass : #Object,
	#instVars : [
		'checkableNode'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToAbstractNodeManager >> buildNode: aNode [ 

]

{ #category : #initialization }
ToAbstractNodeManager >> buildNodeContainer: aNodeContainer [

	| listElement cbox |
	checkableNode ifFalse: [ ^ self ].
	listElement := aNodeContainer holder listElement.
	cbox := listElement newCheckboxInNodeContainer: aNodeContainer.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	aNodeContainer ensureStartContainer.
	aNodeContainer startContainer addChild: cbox
]

{ #category : #accessing }
ToAbstractNodeManager >> checkableNode [

	^ checkableNode
]

{ #category : #accessing }
ToAbstractNodeManager >> checkableNode: aBoolean [

	checkableNode := aBoolean 
]

{ #category : #initialization }
ToAbstractNodeManager >> initialize [ 

	super initialize.
	checkableNode := false
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newHolder [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newNodeContainer [ 

	^ ToNodeContainer new
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newNodeForHolder: aNodeHolder [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractNodeManager >> unbuildNode: aNode [


]
