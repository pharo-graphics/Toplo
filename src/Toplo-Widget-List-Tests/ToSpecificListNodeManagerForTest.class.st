Class {
	#name : #ToSpecificListNodeManagerForTest,
	#superclass : #ToAbstractNodeManager,
	#instVars : [
		'counter'
	],
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #initialization }
ToSpecificListNodeManagerForTest >> buildNode: aNode [

	aNode addChild: (ToLabel text: aNode labelText)
]

{ #category : #initialization }
ToSpecificListNodeManagerForTest >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #initialization }
ToSpecificListNodeManagerForTest >> initialize [ 

	super initialize.
	counter := 0
]

{ #category : #'instance creation' }
ToSpecificListNodeManagerForTest >> newHolder [

	^ ToSpecificListNodeHolderForTest new
		  num: self nextCount;
		  yourself
]

{ #category : #'instance creation' }
ToSpecificListNodeManagerForTest >> newNodeForHolder: aNodeHolder [

	^ ToSpecificListNodeForTest new 
]

{ #category : #accessing }
ToSpecificListNodeManagerForTest >> nextCount [ 

	counter := counter + 1.
	^ counter
]

{ #category : #initialization }
ToSpecificListNodeManagerForTest >> unbuildNode: aNode [

	aNode holder num: 0

]
