Class {
	#name : #ToListNodeHolder,
	#superclass : #ToAbstractNodeHolder,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeHolder >> setDataItemAndBuildNode: aDataItem [ 

	super setDataItemAndBuildNode: aDataItem.
	self node disabled: self isDisabled.
	self isHidden ifTrue: [ self node height: 0 ]
]
