Class {
	#name : #ToSegmentedNodeManager,
	#superclass : #ToCheckableBarNodeManager,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #'as yet unclassified' }
ToSegmentedNodeManager >> defaultFakeDataItem [

	^ ToSegmentedToggleButton new
		  labelText: 'X';
		  yourself
]

{ #category : #'as yet unclassified' }
ToSegmentedNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToSegmentedNode new
]
