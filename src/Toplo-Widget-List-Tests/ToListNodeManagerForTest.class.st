Class {
	#name : #ToListNodeManagerForTest,
	#superclass : #ToBasicListNodeManager,
	#instVars : [
		'counter'
	],
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToListNodeManagerForTest >> buildNode: aNode [

	aNode addChild: (ToLabel text: aNode labelText)
]

{ #category : #initialization }
ToListNodeManagerForTest >> defaultNodeFactory [

	^ [ :holder | ToListNodeForTest new ]
]

{ #category : #initialization }
ToListNodeManagerForTest >> defaultNodeHolderFactory [

	^ [
		  ToListNodeHolderForTest new
			  num: self nextCount;
			  yourself ]
]

{ #category : #initialization }
ToListNodeManagerForTest >> initialize [ 

	super initialize.
	counter := 0
]

{ #category : #accessing }
ToListNodeManagerForTest >> nextCount [ 

	counter := counter + 1.
	^ counter
]

{ #category : #initialization }
ToListNodeManagerForTest >> unbuildNode: aNode [

	aNode holder num: 0

]
