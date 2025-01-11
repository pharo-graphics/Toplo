Class {
	#name : #ToAbstractNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToAbstractNodeHolder >> bindDataItem: aDataItem [

	self setupNodeWith: (self nodeManager newNodeForHolder: self).
	self setDataItemAndBuildNode: aDataItem
]

{ #category : #accessing }
ToAbstractNodeHolder >> data [


	self
		deprecated: 'Use dataItem instead'
		transformWith: '`@receiver data' -> '`@receiver dataItem'.

	^ self dataItem
]

{ #category : #accessing }
ToAbstractNodeHolder >> dataItem [

	^ dataItem ifNotNil: [ :di | di first ]
]

{ #category : #accessing }
ToAbstractNodeHolder >> dataItem: aData [ 

	dataItem := aData asWeakReference
]

{ #category : #accessing }
ToAbstractNodeHolder >> dataSource [

	^ self listElement dataSource
]

{ #category : #accessing }
ToAbstractNodeHolder >> disabled: aBoolean [

	| selecter |
	selecter := self listElement disabledSelecter.
	aBoolean
		ifTrue: [ selecter selectIndex: self position ]
		ifFalse: [ selecter deselectIndex: self position ]
]

{ #category : #accessing }
ToAbstractNodeHolder >> initializeNode [

	self node disabled: self isDisabled.
	self isHidden ifTrue: [ self node height: 0 ]
]

{ #category : #accessing }
ToAbstractNodeHolder >> isDisabled [

	^ self listElement selectionModel isDisabledIndex: self position
]

{ #category : #accessing }
ToAbstractNodeHolder >> isEnabled [

	^ self isDisabled not
]

{ #category : #accessing }
ToAbstractNodeHolder >> isHidden [

	^ self listElement selectionModel isHiddenIndex: self position
]

{ #category : #accessing }
ToAbstractNodeHolder >> isSelectable [

	^ self isUnselectable not
]

{ #category : #accessing }
ToAbstractNodeHolder >> isSelected [

	^ self listElement
		  ifNil: [ false ]
		  ifNotNil: [ :le | le selectionModel containsIndex: self position ]
]

{ #category : #accessing }
ToAbstractNodeHolder >> isUnselectable [

	^ self listElement selectionModel isUnselectableIndex: self position
]

{ #category : #accessing }
ToAbstractNodeHolder >> listElement [

	^ self infiniteElement listElement
]

{ #category : #accessing }
ToAbstractNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToAbstractNodeHolder >> node: aNode [

	itemElement := aNode
]

{ #category : #accessing }
ToAbstractNodeHolder >> nodeManager [ 

	^ self listElement nodeManager
]

{ #category : #accessing }
ToAbstractNodeHolder >> notifyDeselectedWithOption: aSelectionElementOption [

	self isSelected ifTrue: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selectionOption: aSelectionElementOption;
			 selected: false)
]

{ #category : #accessing }
ToAbstractNodeHolder >> notifySelectedWithOption: aSelectionElementOption [

	self isSelected ifFalse: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selectionOption: aSelectionElementOption;
			 selected: true)
]

{ #category : #accessing }
ToAbstractNodeHolder >> release [

	super release.
	dataItem := nil

]

{ #category : #accessing }
ToAbstractNodeHolder >> selecter [ 

	^ self listElement selecter
]

{ #category : #accessing }
ToAbstractNodeHolder >> selectionModel [

	^ self listElement selectionModel
]

{ #category : #accessing }
ToAbstractNodeHolder >> setDataItemAndBuildNode: aDataItem [ 

	| nodeManager |
	self dataItem: aDataItem.
	nodeManager := self nodeManager.
	nodeManager buildNode: self node.
	nodeManager constraintNode: self node.
	self initializeNode
]

{ #category : #accessing }
ToAbstractNodeHolder >> setupNodeWith: aNode [

	| infiniteConstraints |
	self node: aNode.
	infiniteConstraints := aNode constraints infinite.
	infiniteConstraints holder: self
]

{ #category : #accessing }
ToAbstractNodeHolder >> unbindDataItem [

	| nodeManager |
	nodeManager := self listElement nodeManager.
	nodeManager unbuildNode: self node
]
