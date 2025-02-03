Class {
	#name : #ToSpecificBarNodeManagerForTest2,
	#superclass : #ToAbstractBarNodeManager,
	#instVars : [
		'counter'
	],
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #initialization }
ToSpecificBarNodeManagerForTest2 >> buildNode: aNode [

	aNode addChild: aNode holder dataItem
]

{ #category : #initialization }
ToSpecificBarNodeManagerForTest2 >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #initialization }
ToSpecificBarNodeManagerForTest2 >> defaultFakeDataItem [

	^ ToLabel text: 'Fake'
]

{ #category : #initialization }
ToSpecificBarNodeManagerForTest2 >> initialize [ 

	super initialize.
	counter := 0
]

{ #category : #'instance creation' }
ToSpecificBarNodeManagerForTest2 >> newHolder [

	^ ToSpecificBarNodeHolderForTest2 new
		  num: self nextCount;
		  yourself
]

{ #category : #'instance creation' }
ToSpecificBarNodeManagerForTest2 >> newNodeForHolder: aNodeHolder [

	^ ToSpecificBarNodeForTest2 new 
]

{ #category : #accessing }
ToSpecificBarNodeManagerForTest2 >> nextCount [ 

	counter := counter + 1.
	^ counter
]

{ #category : #initialization }
ToSpecificBarNodeManagerForTest2 >> unbuildNode: aNode [

	aNode holder num: 0

]
