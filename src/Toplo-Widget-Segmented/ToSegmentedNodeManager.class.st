Class {
	#name : #ToSegmentedNodeManager,
	#superclass : #ToCheckableBarNodeManager,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #initialization }
ToSegmentedNodeManager >> defaultFakeDataItem [

	^ ToSegmentedToggleButton new
		  labelText: 'X';
		  yourself
]

{ #category : #'instance creation' }
ToSegmentedNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToSegmentedNode new
]
