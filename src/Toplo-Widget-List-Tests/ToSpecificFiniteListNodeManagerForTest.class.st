Class {
	#name : #ToSpecificFiniteListNodeManagerForTest,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToFiniteNodeManager',
	#classTraits : 'TToFiniteNodeManager classTrait',
	#instVars : [
		'counter'
	],
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest >> buildNode: aNode [

	aNode addChild: (ToLabel text: aNode labelText)
]

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest >> defaultFakeDataItem [

	^ 'Fake'
]

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest >> initialize [ 

	super initialize.
	self initializeAsFiniteNodeManager.
	counter := 0
]

{ #category : #'instance creation' }
ToSpecificFiniteListNodeManagerForTest >> newHolder [

	^ ToSpecificFiniteListNodeHolderForTest new
		  num: self nextCount;
		  yourself
]

{ #category : #'instance creation' }
ToSpecificFiniteListNodeManagerForTest >> newNodeForHolder: aNodeHolder [

	^ ToSpecificFiniteListNodeForTest new 
]

{ #category : #accessing }
ToSpecificFiniteListNodeManagerForTest >> nextCount [ 

	counter := counter + 1.
	^ counter
]

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest >> unbuildNode: aNode [

	aNode holder num: 0

]
