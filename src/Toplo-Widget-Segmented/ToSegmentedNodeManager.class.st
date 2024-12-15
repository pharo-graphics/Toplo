Class {
	#name : #ToSegmentedNodeManager,
	#superclass : #ToItemNodeManager,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #initialization }
ToSegmentedNodeManager >> buildNode: aNode [

	| checkableElement holder |
	super buildNode: aNode.
	holder := aNode holder.
	checkableElement := holder dataItem.
	checkableElement hMatchParent.
	"the TToCheckable must be registered in the checkable group managed by the segmented bar"
	checkableElement registerInGroup: holder listElement group
]

{ #category : #initialization }
ToSegmentedNodeManager >> constraintNode: aNode [

	| bar |
	super constraintNode: aNode.
	bar := aNode holder listElement.
	aNode vFitContent.
	bar isVertical
		ifTrue: [
			bar isHMatchParent
				ifTrue: [ aNode hMatchParent ]
				ifFalse: [ aNode hFitContent ] ]
		ifFalse: [
			bar nodeWrapping
				ifTrue: [ aNode hFitContent ]
				ifFalse: [ aNode hMatchParent ] ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultFakeDataItem [

	^ ToSegmentedButton new
		  labelText: 'X';
		  yourself
]

{ #category : #'instance creation' }
ToSegmentedNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToSegmentedNode new
]

{ #category : #initialization }
ToSegmentedNodeManager >> unbuildNode: aNode [

	aNode checkableElement unregisterFromGroup.
	super unbuildNode: aNode 
]
