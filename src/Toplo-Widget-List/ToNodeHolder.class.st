Class {
	#name : #ToNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem',
		'recyclingRequested',
		'notifiedSelected',
		'wasFocused'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder >> allowSelectionNotification: aBoolean [

	notifiedSelected := aBoolean not
]

{ #category : #accessing }
ToNodeHolder >> bindDataItem: aDataItem [
	" associate the data item and then build the node "

	self flag: 'The recycling case have to be re-worked'.
	" I can already have a node in case of recycling "
	self node ifNotNil: [ ^ self ].
	self setupNodeWith: (self nodeManager newNodeForHolder: self).
	self dataItem: aDataItem.
	self nodeManager buildNode: self node
]

{ #category : #selection }
ToNodeHolder >> canNotifyDeselection [ 
	
	^ notifiedSelected or: [ wasFocused ~= self listElement focused ]
]

{ #category : #selection }
ToNodeHolder >> canNotifySelection [ 
	
	^ notifiedSelected not or: [ wasFocused ~= self listElement focused ]
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
	recyclingRequested := false.
	notifiedSelected := false.
	wasFocused := false
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

{ #category : #initialization }
ToNodeHolder >> notifiedSelected [

	^ notifiedSelected 
]

{ #category : #selection }
ToNodeHolder >> notifyDeselectedWithOption: aSelectionElementOption [

	" am i in the selection ?"
	self isSelected ifTrue: [ ^ self ].
	" have I already notified a deselection ? "
	self canNotifyDeselection ifFalse: [ ^ self ].
	self notifyNodeSelectedEvent: (ToListNodeSelectedEvent new
			 listElement: self listElement;
			 selectionOption: aSelectionElementOption;
			 selected: false)
]

{ #category : #selection }
ToNodeHolder >> notifyNodeSelectedEvent: anEvent [ 

	notifiedSelected := anEvent selected.
	wasFocused := self listElement focused.
	self node dispatchEvent: anEvent
]

{ #category : #selection }
ToNodeHolder >> notifySelectedWithOption: aSelectionElementOption [

	" am i in the selection ?"
	self isSelected ifFalse: [ ^ self ].
	" have I already notified a selection ? "
	self canNotifySelection ifFalse: [ ^ self ].
	self notifyNodeSelectedEvent: (ToListNodeSelectedEvent new
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

{ #category : #dependencies }
ToNodeHolder >> release [

	super release.
	dataItem := nil

]

{ #category : #removing }
ToNodeHolder >> removeNodeFromBar [

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
ToNodeHolder >> setupNodeWith: aNode [

	self node: aNode.
	aNode holder: self
]

{ #category : #accessing }
ToNodeHolder >> unbindDataItem [

	| nodeManager |
	nodeManager := self listElement nodeManager.
	nodeManager unbuildNode: self node
]
