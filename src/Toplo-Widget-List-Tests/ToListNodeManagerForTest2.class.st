Class {
	#name : #ToListNodeManagerForTest2,
	#superclass : #ToBasicListNodeManager,
	#instVars : [
		'counter'
	],
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #initialization }
ToListNodeManagerForTest2 >> buildNode: aNode [

	aNode addChild: aNode holder dataItem
]

{ #category : #initialization }
ToListNodeManagerForTest2 >> defaultNodeFactory [

	^ [ :holder | ToListNodeForTest2 new ]
]

{ #category : #initialization }
ToListNodeManagerForTest2 >> defaultNodeHolderFactory [

	^ [
		  ToListNodeHolderForTest2 new
			  num: self nextCount;
			  yourself ]
]

{ #category : #initialization }
ToListNodeManagerForTest2 >> initialize [

	super initialize.
	counter := 0
]

{ #category : #accessing }
ToListNodeManagerForTest2 >> nextCount [ 

	counter := counter + 1.
	^ counter
]

{ #category : #initialization }
ToListNodeManagerForTest2 >> unbuildNode: aNode [

	aNode holder num: 0

]
