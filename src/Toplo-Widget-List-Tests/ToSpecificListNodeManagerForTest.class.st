Class {
	#name : #ToSpecificListNodeManagerForTest,
	#superclass : #ToListNodeManager,
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
ToSpecificListNodeManagerForTest >> defaultNodeFactory [ 

	^ [ :holder |ToSpecificListNodeForTest new ]
]

{ #category : #initialization }
ToSpecificListNodeManagerForTest >> defaultNodeHolderFactory [ 

	^ [ ToSpecificListNodeHolderForTest new
		  num: self nextCount;
		  yourself ]
]

{ #category : #initialization }
ToSpecificListNodeManagerForTest >> initialize [ 

	super initialize.
	counter := 0
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
