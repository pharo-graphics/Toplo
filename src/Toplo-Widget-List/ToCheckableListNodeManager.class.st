Class {
	#name : #ToCheckableListNodeManager,
	#superclass : #ToItemListNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToCheckableListNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToListCheckableNode new ]
]
