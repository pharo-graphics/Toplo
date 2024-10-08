Class {
	#name : #ToSegmentedNodeHolder,
	#superclass : #ToListNodeHolder,
	#category : #'Toplo-Widget-Segmented-Node'
}

{ #category : #accessing }
ToSegmentedNodeHolder >> checkableElement [

	^ self dataItem
]

{ #category : #'t - checkable - accessing' }
ToSegmentedNodeHolder >> checked [

	^ self checkableElement checked
]

{ #category : #'t - checkable - accessing' }
ToSegmentedNodeHolder >> checked: aBoolean [

	self checkableElement checked: aBoolean
]

{ #category : #'t - checkable - accessing' }
ToSegmentedNodeHolder >> isChecked [ 

	^ self checked
]

{ #category : #testing }
ToSegmentedNodeHolder >> isDisabled [

	^ super isDisabled or: [ self isUnselectable  ]
]

{ #category : #testing }
ToSegmentedNodeHolder >> isSelectable [

	^ super isSelectable and: [ self isEnabled ]
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

	self checkableElement checked ifTrue: [
		self selecter selectIndex: self position.
		^ self ].
	self selecter deselectIndex: self position
]
