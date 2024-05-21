Class {
	#name : #ToNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder >> bindDataItem: aDataItem [

	| nodeManager |
	nodeManager := self listElement nodeManager.
	self dataItem: aDataItem. 
	self node: (nodeManager newNodeInHolder: self).
	nodeManager buildNode: self node inHolder: self.
	self node enabled: self isEnabled.
	self isHidden ifTrue: [ self node height: 0 ]
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

{ #category : #testing }
ToNodeHolder >> isDisabled [

	^ self listElement selectionModel isDisabledIndex: self position
]

{ #category : #testing }
ToNodeHolder >> isEnabled [

	^ self isDisabled not
]

{ #category : #testing }
ToNodeHolder >> isHidden [

	^ self listElement selectionModel isHiddenIndex: self position
]

{ #category : #testing }
ToNodeHolder >> isSelectable [

	^ self isUnselectable not
]

{ #category : #testing }
ToNodeHolder >> isSelected [

	^ self listElement
		  ifNil: [ false ]
		  ifNotNil: [ :le | le selectionModel containsIndex: self position ]
]

{ #category : #testing }
ToNodeHolder >> isUnselectable [

	^ self listElement selectionModel isUnselectableIndex: self position
]

{ #category : #accessing }
ToNodeHolder >> listElement [

	^ infiniteElement listElement
]

{ #category : #accessing }
ToNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder >> node: aNode [

	itemElement := aNode
]

{ #category : #dependencies }
ToNodeHolder >> release [

	super release.
	dataItem := nil

]

{ #category : #accessing }
ToNodeHolder >> unbindDataItem [

	| nodeManager |
	nodeManager := self listElement nodeManager.	
	self node release.
	self release

]
