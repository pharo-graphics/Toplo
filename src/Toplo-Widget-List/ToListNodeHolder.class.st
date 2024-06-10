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

	| nodeManager |
	nodeManager := self nodeManager.
	self dataItem: aDataItem.
	self node: (nodeManager newNodeForHolder: self).
	nodeManager buildNode: self node inHolder: self.
	nodeManager constraintNode: self node.
	self node enabled: self isEnabled.
	self isHidden ifTrue: [ self node height: 0 ]
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

	^ dataItem
]

{ #category : #accessing }
ToListNodeHolder >> dataItem: aData [ 

	dataItem := aData
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

	^ infiniteElement listElement
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

{ #category : #dependencies }
ToListNodeHolder >> release [

	super release.
	dataItem := nil

]

{ #category : #accessing }
ToListNodeHolder >> unbindDataItem [

	| nodeManager |
	nodeManager := self listElement nodeManager.
	nodeManager unbindNode: self node.
	self node release.
	self release

]
