Class {
	#name : #ToCheckableFiniteListNodeManager,
	#superclass : #ToItemFiniteListNodeManager,
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #initialization }
ToCheckableFiniteListNodeManager >> buildNode: aNode [

	| checkableElement holder |
	super buildNode: aNode.
	holder := aNode holder.
	checkableElement := aNode item.
	"the TToCheckable must be registered in the checkable group managed by the checkable bar"
	checkableElement registerInGroup: holder listElement group
]

{ #category : #initialization }
ToCheckableFiniteListNodeManager >> defaultFakeDataItem [

	^ ToToggleButton new
		  labelText: 'X';
		  yourself
]

{ #category : #'instance creation' }
ToCheckableFiniteListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToFiniteListCheckableNode new
]

{ #category : #initialization }
ToCheckableFiniteListNodeManager >> unbuildNode: aNode [

	aNode holder dataItem unregisterFromGroup.
	super unbuildNode: aNode 
]
