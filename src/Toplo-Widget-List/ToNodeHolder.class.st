Class {
	#name : #ToNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem',
		'recyclingRequested'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder >> bindDataItem: aDataItem [
	" associate the data item and then build the node "

	self flag: 'The recycling case have to be re-worked'.
	" I can already have a node in case of recycling "
	self node ifNil: [
		self setupNodeWith: (self nodeManager newNodeForHolder: self).
		self setDataItemAndBuildNode: aDataItem ]
]

{ #category : #accessing }
ToNodeHolder >> data [


	self
		deprecated: 'Use dataItem instead'
		transformWith: '`@receiver data' -> '`@receiver dataItem'.

	^ self dataItem
]

{ #category : #accessing }
ToNodeHolder >> dataItem [

	^ dataItem 
]

{ #category : #accessing }
ToNodeHolder >> dataItem: aData [ 

	dataItem := aData
]

{ #category : #accessing }
ToNodeHolder >> dataSource [

	^ self listElement dataSource
]

{ #category : #accessing }
ToNodeHolder >> disabled: aBoolean [

	| selecter |
	selecter := self listElement disabledSelecter.
	aBoolean
		ifTrue: [ selecter selectIndex: self position ]
		ifFalse: [ selecter deselectIndex: self position ]
]

{ #category : #initialization }
ToNodeHolder >> initialize [ 

	super initialize.
	recyclingRequested := false
]

{ #category : #accessing }
ToNodeHolder >> initializeNode [

	self node disabled: self isDisabled.
	self isHidden ifTrue: [ self node height: 0 ]
]

{ #category : #accessing }
ToNodeHolder >> isDisabled [

	^ self listElement selectionModel isDisabledIndex: self position
]

{ #category : #accessing }
ToNodeHolder >> isEnabled [

	^ self isDisabled not
]

{ #category : #accessing }
ToNodeHolder >> isHidden [

	^ self listElement selectionModel isHiddenIndex: self position
]

{ #category : #accessing }
ToNodeHolder >> isSelectable [

	^ self isUnselectable not
]

{ #category : #accessing }
ToNodeHolder >> isSelected [

	^ self listElement
		  ifNil: [ false ]
		  ifNotNil: [ :le | le selectionModel containsIndex: self position ]
]

{ #category : #accessing }
ToNodeHolder >> isUnselectable [

	^ self listElement selectionModel isUnselectableIndex: self position
]

{ #category : #accessing }
ToNodeHolder >> listElement [

	^ self infiniteElement listElement
]

{ #category : #accessing }
ToNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder >> node: aNode [

	itemElement := aNode
]

{ #category : #accessing }
ToNodeHolder >> nodeManager [ 

	^ self listElement nodeManager
]

{ #category : #accessing }
ToNodeHolder >> notifyDeselectedWithOption: aSelectionElementOption [
	self isSelected ifTrue: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selectionOption: aSelectionElementOption;
			 selected: false)
]

{ #category : #accessing }
ToNodeHolder >> notifySelectedWithOption: aSelectionElementOption [

	self isSelected ifFalse: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selectionOption: aSelectionElementOption;
			 selected: true)
]

{ #category : #accessing }
ToNodeHolder >> recyclingRequested [

	^ recyclingRequested
]

{ #category : #accessing }
ToNodeHolder >> recyclingRequested: aBoolean [

	recyclingRequested := aBoolean
]

{ #category : #accessing }
ToNodeHolder >> release [

	super release.
	dataItem := nil

]

{ #category : #removing }
ToNodeHolder >> removeNodeFromBar [
	" 
	since a select node is created by selecting and item in the list element, 
	removing the node is done by deselecting the corresponding list item in the select popu list "

	self dataSource removeAt: self position
]

{ #category : #accessing }
ToNodeHolder >> selecter [ 

	^ self listElement selecter
]

{ #category : #accessing }
ToNodeHolder >> selectionModel [

	^ self listElement selectionModel
]

{ #category : #accessing }
ToNodeHolder >> setDataItemAndBuildNode: aDataItem [ 

	| nodeManager |
	self dataItem: aDataItem.
	nodeManager := self nodeManager.
	nodeManager buildNode: self node.
	self initializeNode
]

{ #category : #accessing }
ToNodeHolder >> setupNodeWith: aNode [

	| infiniteConstraints |
	self node: aNode.
	infiniteConstraints := aNode constraints infinite.
	infiniteConstraints holder: self
]

{ #category : #accessing }
ToNodeHolder >> unbindDataItem [

	| nodeManager |
	nodeManager := self listElement nodeManager.
	nodeManager unbuildNode: self node
]
