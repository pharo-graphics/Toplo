Class {
	#name : #ToMultiSelectBarElement,
	#superclass : #ToBarElement,
	#traits : 'TToSelectInnerContainerElement',
	#classTraits : 'TToSelectInnerContainerElement classTrait',
	#instVars : [
		'selectElement',
		'textInputElement',
		'pickCount',
		'maxSelectedCount',
		'keepPickOrder'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToMultiSelectBarElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> allowSelectedCount: aNumber [

	^ maxSelectedCount isZero or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> checkHideSelectionFromListElement [

	selectElement hideSelected ifFalse: [ ^ self ].
	self listElement hideSelection
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> checkMaxSelectedCount [

	| sM unselectableSM groupeSM selectedIndexCount |
	maxSelectedCount isZero ifTrue: [ ^ self ].

	unselectableSM := self listElement unselectableSelectionModel.
	groupeSM := self listElement groupSelectionModel.
	sM := self listElement selectionModel.

	selectElement updateSelectedCountLabel.
	selectedIndexCount := self sieve selectionModel selectedIndexesCount.

	self assertMaxSelectedCount: selectedIndexCount.
	self sieve currentDataWithLocalAndOriginalIndexDo: [
		:d
		:localIndex
		:originalIndex |
		(groupeSM containsIndex: localIndex) ifFalse: [
			selectedIndexCount < maxSelectedCount
				ifTrue: [ unselectableSM deselectIndex: localIndex ]
				ifFalse: [
					(selectElement selectionModel containsIndex: originalIndex)
						ifFalse: [ unselectableSM selectIndex: localIndex ] ] ] ].

	self listElement notifyDataSourceChanged
]

{ #category : #initialization }
ToMultiSelectBarElement >> defaultEventHandler [ 

	^ ToMultiSelectBarEventHandler new
]

{ #category : #initialization }
ToMultiSelectBarElement >> defaultNodeManager [

	^ ToMultiSelectBarNodeManager new
]

{ #category : #layout }
ToMultiSelectBarElement >> haveFullyInvisibleNodes: theInvisibleNodes [

	| visibleNodes invisibleNodes shower finalCount |
	" in case of composite node at first it means that 
	there is no more visible node to cumulate in a composite node"
	self nodes size = 1 ifTrue: [ ^ self ].

	visibleNodes := self nodesSelect: [ :n | n isFullyVisible ].
	invisibleNodes := theInvisibleNodes copy.
	visibleNodes ifNotEmpty: [
		invisibleNodes := theInvisibleNodes copyWith: visibleNodes last.
		visibleNodes := visibleNodes copyWithout: visibleNodes last ].

	" now cumulate invisible nodes in a composite holder "
	shower := ToMultiSelectCompositeItem new.
	shower items: (Array streamContents: [ :stream |
			 invisibleNodes do: [ :n |
				 stream nextPutAll: n holder dataItem items ] ]).
	shower indexes: (Array streamContents: [ :stream |
			 invisibleNodes do: [ :node |
				 stream nextPutAll: node holder dataItem indexes ] ]).

	finalCount := self nodesCount - visibleNodes size.
	shower content: '+ ' , finalCount asString , ' ...'.
	invisibleNodes do: [ :node |
		self dataAccessor removeAt: node holder position ].
	self dataAccessor add: shower
]

{ #category : #initialization }
ToMultiSelectBarElement >> initialize [

	super initialize.
	self installTextInputElement.
	
	" no primary and secondary selection elements "
	self primarySelectionMode option masked: true.
	self secondarySelectionMode option masked: true.

	maxSelectedCount := 0.
	keepPickOrder := false.
	pickCount := 0.

	" mandatory resizer setting. 
	Normally, should not be changed"
	self vFitContent.
	self hMatchParent 
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> installTextInputElement [

	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self.
	
	textInputElement hFitContent.
	textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	self addChild: textInputElement

]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> isMultipleSelection [ 

	^ true
]

{ #category : #accessing }
ToMultiSelectBarElement >> keepPickOrder [

	^ keepPickOrder 
]

{ #category : #accessing }
ToMultiSelectBarElement >> keepPickOrder: aBoolean [

	keepPickOrder := aBoolean.
	self refresh
]

{ #category : #accessing }
ToMultiSelectBarElement >> listElement [

	^ selectElement listElement
]

{ #category : #accessing }
ToMultiSelectBarElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber.
	self refresh
]

{ #category : #skin }
ToMultiSelectBarElement >> newRawSkin [ 

	^ ToMultiSelectBarElementSkin new
]

{ #category : #'t - children - accessing' }
ToMultiSelectBarElement >> nodes [

	^ self innerContainer nodes
]

{ #category : #accessing }
ToMultiSelectBarElement >> nodesCount [

	| count |
	count := 0.
	self nodesDo: [ :node |
		count := count + node nodesCount ].
	^ count
]

{ #category : #accessing }
ToMultiSelectBarElement >> nodesDo: aBlock [

	self innerContainer nodesDo: aBlock
]

{ #category : #accessing }
ToMultiSelectBarElement >> nodesSelect: aBlock [

	^ self innerContainer nodesSelect: aBlock
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> refresh [
	" first remove all data nodes "

	| previousItems newItems |
	selectElement showHidePlaceholder.

	self selecter deselectAll.
	" copy the previous items "
	previousItems := self dataAccessor asOrderedCollection.
	newItems := OrderedCollection new.
	" take care of a possible composite that represents a list of items "
	previousItems ifNotEmpty: [
		| last |
		last := previousItems last.
		last isComposite ifTrue: [
			previousItems removeLast.
			previousItems addAll: last items ] ].

	" reconstruct the item list. ensure the reuse of pre-existing items"
	selectElement selectionModel selectedIndexesDo: [ :idx |
		| new previous |
		previous := previousItems
			            detect: [ :item | item index = idx ]
			            ifNone: [  ].
		previous
			ifNotNil: [
				new := previous.
				previousItems remove: previous ]
			ifNil: [
				new := ToMultiSelectItem index: idx.
				pickCount := pickCount + 1.
				new pickOrder: pickCount ].
		newItems add: new ].

	keepPickOrder ifTrue: [
		newItems sort: [ :a :b | a pickOrder < b pickOrder ] ].

	" replace all in one datasource command "
	self dataAccessor updateAllWith: newItems.
	self selecter selectAll.

	self checkHideSelectionFromListElement.
	self checkMaxSelectedCount
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> selectElement [

	^ selectElement
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToMultiSelectBarElement >> sieve [ 

	^ selectElement sieve
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> textInputElement [ 

	^ textInputElement 
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> textInputElementClass [

	^ ToMultiSelectTextInputElement
]
