Class {
	#name : #ToCheckableBarNodeManager,
	#superclass : #ToItemBarNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToCheckableBarNodeManager >> buildNode: aNode [

	| checkableElement holder |
	super buildNode: aNode.
	holder := aNode holder.
	checkableElement := holder dataItem.
	checkableElement hMatchParent.
	"the TToCheckable must be registered in the checkable group managed by the segmented bar"
	checkableElement registerInGroup: holder listElement group
]

{ #category : #initialization }
ToCheckableBarNodeManager >> unbuildNode: aNode [

	aNode holder dataItem unregisterFromGroup.
	super unbuildNode: aNode 
]
