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
	checkableElement := aNode item.
	"the TToCheckable must be registered in the checkable group managed by the checkable bar"
	checkableElement registerInGroup: holder listElement group
]

{ #category : #initialization }
ToCheckableBarNodeManager >> defaultFakeDataItem [

	^ ToItemToggleButton new
		  labelText: 'X';
		  yourself
]

{ #category : #'instance creation' }
ToCheckableBarNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToCheckableNode new
]

{ #category : #initialization }
ToCheckableBarNodeManager >> unbuildNode: aNode [

	aNode holder dataItem unregisterFromGroup.
	super unbuildNode: aNode 
]
