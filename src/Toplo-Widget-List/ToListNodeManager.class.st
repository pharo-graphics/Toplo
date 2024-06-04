Class {
	#name : #ToListNodeManager,
	#superclass : #ToAbstractListNodeManager,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToListNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :dataItem |
	  node addChild: (ToLabel text: dataItem asString) hMatchParent ]
]
