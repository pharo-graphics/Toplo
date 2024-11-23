Class {
	#name : #ToSpecificBarNodeManagerForTest,
	#superclass : #ToAbstractBarNodeManager,
	#instVars : [
		'counter'
	],
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #initialization }
ToSpecificBarNodeManagerForTest >> buildNode: aNode [

	aNode addChild: (ToLabel text: aNode labelText)
]

{ #category : #initialization }
ToSpecificBarNodeManagerForTest >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #initialization }
ToSpecificBarNodeManagerForTest >> defaultFakeDataItem [

	^ 'Fake'
]

{ #category : #initialization }
ToSpecificBarNodeManagerForTest >> initialize [ 

	super initialize.
	counter := 0
]

{ #category : #'instance creation' }
ToSpecificBarNodeManagerForTest >> newHolder [

	^ ToSpecificBarNodeHolderForTest new
		  num: self nextCount;
		  yourself
]

{ #category : #'instance creation' }
ToSpecificBarNodeManagerForTest >> newNodeForHolder: aNodeHolder [

	^ ToSpecificBarNodeForTest new 
]

{ #category : #accessing }
ToSpecificBarNodeManagerForTest >> nextCount [ 

	counter := counter + 1.
	^ counter
]

{ #category : #initialization }
ToSpecificBarNodeManagerForTest >> unbuildNode: aNode [

	aNode removeChildren.
	aNode holder num: 0

]
