Class {
	#name : #ToSpecificFiniteListNodeManagerForTest,
	#superclass : #ToAbstractFiniteNodeManager,
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
ToSpecificFiniteListNodeManagerForTest >> defaultNodeFactory [

	^ [ :holder | ToSpecificFiniteListNodeForTest new ]
]

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest >> defaultNodeHolderFactory [

	^ [
		  ToSpecificFiniteListNodeHolderForTest new
			  num: self nextCount;
			  yourself ]
]

{ #category : #initialization }
ToSpecificFiniteListNodeManagerForTest >> initialize [ 

	super initialize.
	counter := 0
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
