Class {
	#name : #ToListNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeHolder >> bindDataItem: aDataItem [

	self node: (self nodeManager newNodeForHolder: self).
	self setDataItemAndBuildNode: aDataItem.

]

{ #category : #accessing }
ToListNodeHolder >> data [


	self
		deprecated: 'Use dataItem instead'
		transformWith: '`@receiver data' -> '`@receiver dataItem'.

	^ self dataItem
]

{ #category : #accessing }
ToListNodeHolder >> dataItem [

	^ dataItem ifNotNil: [ :di | di first ]
]

{ #category : #accessing }
ToListNodeHolder >> dataItem: aData [ 

	dataItem := aData asWeakReference
]

{ #category : #accessing }
ToListNodeHolder >> dataSource [

	^ self listElement dataSource
]

{ #category : #testing }
ToListNodeHolder >> isDisabled [

	^ self listElement selectionModel isDisabledIndex: self position
]

{ #category : #testing }
ToListNodeHolder >> isEnabled [

	^ self isDisabled not
]

{ #category : #testing }
ToListNodeHolder >> isHidden [

	^ self listElement selectionModel isHiddenIndex: self position
]

{ #category : #testing }
ToListNodeHolder >> isSelectable [

	^ self isUnselectable not
]

{ #category : #testing }
ToListNodeHolder >> isSelected [

	^ self listElement
		  ifNil: [ false ]
		  ifNotNil: [ :le | le selectionModel containsIndex: self position ]
]

{ #category : #testing }
ToListNodeHolder >> isUnselectable [

	^ self listElement selectionModel isUnselectableIndex: self position
]

{ #category : #accessing }
ToListNodeHolder >> listElement [

	^ self infiniteElement listElement
]

{ #category : #accessing }
ToListNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToListNodeHolder >> node: aNode [

	itemElement := aNode
]

{ #category : #accessing }
ToListNodeHolder >> nodeManager [ 

	^ self listElement nodeManager
]

{ #category : #'selection notification' }
ToListNodeHolder >> notifyDeselectedInGroupHolder: aSelectionGroupHolder [

	self isSelected ifTrue: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selectionOption: aSelectionGroupHolder selectionElementOption;
			 selected: false)
]

{ #category : #'selection notification' }
ToListNodeHolder >> notifySelectedInGroupHolder: aSelectionGroupHolder [

	self isSelected ifFalse: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selectionOption: aSelectionGroupHolder selectionElementOption;
			 selected: true)
]

{ #category : #dependencies }
ToListNodeHolder >> release [

	super release.
	dataItem := nil

]

{ #category : #accessing }
ToListNodeHolder >> selecter [ 

	^ self listElement selecter
]

{ #category : #accessing }
ToListNodeHolder >> selectionModel [

	^ self listElement selectionModel
]

{ #category : #accessing }
ToListNodeHolder >> setDataItemAndBuildNode: aDataItem [ 

	| nodeManager |
	self dataItem: aDataItem.
	nodeManager := self nodeManager.
	nodeManager buildNode: self node inHolder: self.
	nodeManager constraintNode: self node.
	self node enabled: self isEnabled.
	self isHidden ifTrue: [ self node height: 0 ]
]

{ #category : #accessing }
ToListNodeHolder >> unbindDataItem [

	| nodeManager |
	nodeManager := self listElement nodeManager.
	nodeManager unbuildNode: self node
]
