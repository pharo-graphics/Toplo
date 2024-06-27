Class {
	#name : #ToListNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem',
		'wasSelected'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeHolder >> bindDataItem: aDataItem [

	| nodeManager |
	nodeManager := self nodeManager.
	self dataItem: aDataItem.
	self node: (nodeManager newNodeForHolder: self).
	self build
]

{ #category : #accessing }
ToListNodeHolder >> build [

	| nodeManager |
	nodeManager := self nodeManager.
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

{ #category : #'selection notification' }
ToListNodeHolder >> ensureNotifySelected [

	self isSelected ifFalse: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selected: true).
]

{ #category : #accessing }
ToListNodeHolder >> forgetSelection [

	wasSelected := false
]

{ #category : #initialization }
ToListNodeHolder >> initialize [ 

	super initialize.
	wasSelected := false
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

{ #category : #'selection notification' }
ToListNodeHolder >> notifyDeselected [

	(wasSelected and: [ self isSelected not ]) ifFalse: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selected: false)
]

{ #category : #'selection notification' }
ToListNodeHolder >> notifySelected [

	(wasSelected not and: [ self isSelected ]) ifFalse: [ ^ self ].
	self node dispatchEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selected: true)
]

{ #category : #dependencies }
ToListNodeHolder >> release [

	super release.
	dataItem := nil

]

{ #category : #accessing }
ToListNodeHolder >> rememberSelection [

	wasSelected := self isSelected 
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
ToListNodeHolder >> unbindDataItem [

	| nodeManager |
	
	nodeManager := self listElement nodeManager.
	nodeManager unbindNode: self node.
	self node release.
	self release

]

{ #category : #accessing }
ToListNodeHolder >> wasSelected [

	^ wasSelected
]

{ #category : #accessing }
ToListNodeHolder >> wasSelected: aBoolean [

	wasSelected := aBoolean
]
