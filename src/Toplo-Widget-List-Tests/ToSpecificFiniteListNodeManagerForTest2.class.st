Class {
	#name : #ToSpecificFiniteListNodeManagerForTest2,
	#superclass : #ToAbstractFiniteNodeManager,
	#instVars : [
		'counter'
	],
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest2 >> buildNode: aNode [

	aNode addChild: aNode holder dataItem
]

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest2 >> defaultFakeDataItem [

	^ ToLabel text: 'Fake'
]

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest2 >> initialize [

	super initialize.
	counter := 0
]

{ #category : #'instance creation' }
ToSpecificFiniteListNodeManagerForTest2 >> newHolder [

	^ ToSpecificFiniteListNodeHolderForTest2 new
		  num: self nextCount;
		  yourself
]

{ #category : #'instance creation' }
ToSpecificFiniteListNodeManagerForTest2 >> newNodeForHolder: aNodeHolder [

	^ ToSpecificFiniteListNodeForTest2 new 
]

{ #category : #accessing }
ToSpecificFiniteListNodeManagerForTest2 >> nextCount [ 

	counter := counter + 1.
	^ counter
]

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest2 >> unbuildNode: aNode [

	aNode holder num: 0

]
