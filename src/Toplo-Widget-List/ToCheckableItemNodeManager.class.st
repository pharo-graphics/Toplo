Class {
	#name : #ToCheckableItemNodeManager,
	#superclass : #ToItemListNodeManager,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
ToCheckableItemNodeManager >> buildNode: aNode [

	| checkableElement holder |
	super buildNode: aNode.
	holder := aNode holder.
	checkableElement := holder dataItem.
	checkableElement hMatchParent.
	"the TToCheckable must be registered in the checkable group managed by the segmented bar"
	checkableElement registerInGroup: holder listElement group
]

{ #category : #initialization }
ToCheckableItemNodeManager >> unbuildNode: aNode [

	aNode holder dataItem unregisterFromGroup.
	super unbuildNode: aNode 
]
