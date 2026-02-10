"
I'm a connection between several pieces of information. 

I refer to 
- a nodeContainer element
- a list element (accessible via the infinite element) 
- a node element
- the data 

For each of this information look at my public API
"
Class {
	#name : #ToNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem',
		'recyclingRequested',
		'wasFocused',
		'selectionNotificationMap'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder >> bindDataItem: aDataItem [
	" associate the data item and then build the node "

	self flag: 'The recycling case have to be re-worked'.
	" I can already have a node in case of recycling "
	self nodeContainer ifNotNil: [ ^ self ].
	self setupNodeContainerWith: (self nodeManager newNodeContainer).
	self dataItem: (self unwrappedDataItemFrom: aDataItem).

	self nodeManager buildNodeContainer: self nodeContainer.
	self nodeManager buildNode: self node
]

{ #category : #selection }
ToNodeHolder >> canNotifyDeselectionForOption: aSelectionOption [
	" true if the focus changed or if it was selected previously. 
	true by default if not selected/deselected yet "

	^ wasFocused ~= self listElement focused or: [
		  selectionNotificationMap at: aSelectionOption ifAbsent: [ true ] ]
]

{ #category : #selection }
ToNodeHolder >> canNotifySelectionForOption: aSelectionOption [
	" true if the focus changed or if it was not selected previously. 
	true by default if not selected/deselected yet "

	^ wasFocused ~= self listElement focused or: [
			  (selectionNotificationMap
				   at: aSelectionOption
				   ifAbsent: [ false ]) not ]
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
		ifTrue: [
			self isDisabled ifFalse: [
				selecter selectOneMoreIndex: self position ] ]
		ifFalse: [
		self isEnabled ifFalse: [ selecter deselectIndex: self position ] ]
]

{ #category : #accessing }
ToNodeHolder >> fakeDataItem: aData [ 

	self dataItem: aData
]

{ #category : #initialization }
ToNodeHolder >> initialize [ 

	super initialize.
	selectionNotificationMap := SmallIdentityDictionary new.
	recyclingRequested := false.
	" don't initialize notifiedSelected to false 
	to force correct update of selection at start"
	wasFocused := false
]

{ #category : #accessing }
ToNodeHolder >> initializeNodeSelections [

	self node disabled: self isDisabled.
	self isHidden ifTrue: [ self nodeContainer height: 0 ]
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
ToNodeHolder >> listInnerElement [

	^ self infiniteElement
]

{ #category : #accessing }
ToNodeHolder >> node [

	^ self nodeContainer node 
]

{ #category : #accessing }
ToNodeHolder >> nodeContainer [

	^ self itemElement
]

{ #category : #accessing }
ToNodeHolder >> nodeContainer: aNodeContainer [

	itemElement := aNodeContainer
]

{ #category : #accessing }
ToNodeHolder >> nodeDepth [

	^ 0
]

{ #category : #accessing }
ToNodeHolder >> nodeManager [ 

	^ self listElement nodeManager
]

{ #category : #selection }
ToNodeHolder >> notifySelectedSkinEvent: aSelectionEvent [

	selectionNotificationMap at: aSelectionEvent selectionOption put: aSelectionEvent selected.
	wasFocused := aSelectionEvent focused.

	self nodeContainer skinManagerDo: [ :sm |
		sm selectedSkinEvent: aSelectionEvent in: self nodeContainer ]
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
ToNodeHolder >> removeNodeFromList [

	self dataSource removeAt: self position
]

{ #category : #accessing }
ToNodeHolder >> selected: aBoolean [

	aBoolean
		ifTrue: [ self selecter selectIndex: self position ]
		ifFalse: [ self selecter deselectIndex: self position ]
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
ToNodeHolder >> setupNodeContainerWith: aNodeContainer [

	self nodeContainer: aNodeContainer.
	aNodeContainer holder: self
]

{ #category : #accessing }
ToNodeHolder >> unbindDataItem [

	| nodeManager |
	nodeManager := self listElement nodeManager.
	nodeManager unbuildNode: self node
]

{ #category : #accessing }
ToNodeHolder >> unwrappedDataItemFrom: aDataItem [

	^ aDataItem
]
