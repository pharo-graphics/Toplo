Class {
	#name : #ToCheckableListNodeManager,
	#superclass : #ToItemListNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToCheckableListNodeManager >> buildNode: aNode [

	super buildNode: aNode
]

{ #category : #initialization }
ToCheckableListNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToListCheckableNode new ]
]

{ #category : #initialization }
ToCheckableListNodeManager >> unbuildNode: aNode [

	super unbuildNode: aNode 
]
