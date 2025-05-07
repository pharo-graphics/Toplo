Class {
	#name : #ToCheckableListNodeManager,
	#superclass : #ToItemListNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToCheckableListNodeManager >> buildNode: aNode [

	| checkableElement holder |
	super buildNode: aNode.
	holder := aNode holder.
	checkableElement := holder dataItem.
	checkableElement hMatchParent.
	"the TToCheckable must be registered in the checkable group managed by the segmented bar"
	checkableElement registerInGroup: holder listElement group
]

{ #category : #'instance creation' }
ToCheckableListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToListCheckableNode new
]

{ #category : #initialization }
ToCheckableListNodeManager >> unbuildNode: aNode [

	aNode holder dataItem unregisterFromGroup.
	super unbuildNode: aNode 
]
