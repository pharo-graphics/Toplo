Class {
	#name : #ToCheckableNodeManager,
	#superclass : #ToItemNodeManager,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'as yet unclassified' }
ToCheckableNodeManager >> buildNode: aNode [

	| checkableElement holder |
	super buildNode: aNode.
	holder := aNode holder.
	checkableElement := holder dataItem.
	checkableElement hMatchParent.
	"the TToCheckable must be registered in the checkable group managed by the segmented bar"
	checkableElement registerInGroup: holder listElement group
]

{ #category : #'as yet unclassified' }
ToCheckableNodeManager >> unbuildNode: aNode [

	aNode checkableElement unregisterFromGroup.
	super unbuildNode: aNode 
]
