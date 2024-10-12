Class {
	#name : #ToSegmentedNodeHolder,
	#superclass : #ToListNodeHolder,
	#category : #'Toplo-Widget-Segmented-Node'
}

{ #category : #accessing }
ToSegmentedNodeHolder >> segmentedBarElement [

	^ self listElement
]

{ #category : #accessing }
ToSegmentedNodeHolder >> setDataItemAndBuildNode: aDataItem [

	super setDataItemAndBuildNode: aDataItem.
	" aDataItem is a TToCheckable. 
	It must be registered in the checkable group managed by the segmented bar"
	aDataItem registerInGroup: self segmentedBarElement group
]
