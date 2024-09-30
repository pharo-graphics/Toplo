Class {
	#name : #ToSegmentedNodeHolder,
	#superclass : #ToListNodeHolder,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'t - checkable - accessing' }
ToSegmentedNodeHolder >> checked [

	^ self contentElement checked
]

{ #category : #'t - checkable - accessing' }
ToSegmentedNodeHolder >> checked: aBoolean [

	self contentElement checked: aBoolean.
	self updateSelection
]

{ #category : #accessing }
ToSegmentedNodeHolder >> contentElement [

	^ self dataItem
]

{ #category : #'t - checkable - accessing' }
ToSegmentedNodeHolder >> isChecked [ 

	^ self checked
]

{ #category : #accessing }
ToSegmentedNodeHolder >> segmentedBarElement [

	^ self listElement
]

{ #category : #accessing }
ToSegmentedNodeHolder >> setDataItemAndBuildNode: aDataItem [

	super setDataItemAndBuildNode: aDataItem.
	" aDataItem is a checkable element. 
	It must be registered in the checkable group managed by the segmented bar"
	aDataItem registerInGroup: self segmentedBarElement group
]

{ #category : #'t - checkable - accessing' }
ToSegmentedNodeHolder >> updateSelection [

	self contentElement checked ifTrue: [
		self selecter selectIndex: self position.
		^ self ].
	self selecter deselectIndex: self position
]
