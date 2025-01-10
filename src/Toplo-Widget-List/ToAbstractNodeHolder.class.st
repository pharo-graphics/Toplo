Class {
	#name : #ToAbstractNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> bindDataItem: aDataItem [

	self setupNodeWith: (self nodeManager newNodeForHolder: self).
	self setDataItemAndBuildNode: aDataItem
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> data [


	self
		deprecated: 'Use dataItem instead'
		transformWith: '`@receiver data' -> '`@receiver dataItem'.

	^ self dataItem
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> dataItem [

	^ dataItem ifNotNil: [ :di | di first ]
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> dataItem: aData [ 

	dataItem := aData asWeakReference
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> dataSource [

	^ self listElement dataSource
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> isDisabled [

	^ self listElement selectionModel isDisabledIndex: self position
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> isEnabled [

	^ self isDisabled not
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> isHidden [

	^ self listElement selectionModel isHiddenIndex: self position
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> isSelectable [

	^ self isUnselectable not
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> isSelected [

	^ self listElement
		  ifNil: [ false ]
		  ifNotNil: [ :le | le selectionModel containsIndex: self position ]
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> isUnselectable [

	^ self listElement selectionModel isUnselectableIndex: self position
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> listElement [

	^ self infiniteElement listElement
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> node [

	^ self itemElement 
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> node: aNode [

	itemElement := aNode
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> nodeManager [ 

	^ self listElement nodeManager
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> notifyDeselectedWithOption: aSelectionElementOption [

	self isSelected ifTrue: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selectionOption: aSelectionElementOption;
			 selected: false)
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> notifySelectedWithOption: aSelectionElementOption [

	self isSelected ifFalse: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selectionOption: aSelectionElementOption;
			 selected: true)
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> release [

	super release.
	dataItem := nil

]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> selecter [ 

	^ self listElement selecter
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> selectionModel [

	^ self listElement selectionModel
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> setDataItemAndBuildNode: aDataItem [ 

	| nodeManager |
	self dataItem: aDataItem.
	nodeManager := self nodeManager.
	nodeManager buildNode: self node.
	nodeManager constraintNode: self node.
	self initializeNode
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> setupNodeWith: aNode [

	| infiniteConstraints |
	self node: aNode.
	infiniteConstraints := aNode constraints infinite.
	infiniteConstraints holder: self
]

{ #category : #'as yet unclassified' }
ToAbstractNodeHolder >> unbindDataItem [

	| nodeManager |
	nodeManager := self listElement nodeManager.
	nodeManager unbuildNode: self node
]
