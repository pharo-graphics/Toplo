Class {
	#name : #ToMultiSelectBarElement,
	#superclass : #ToBarElement,
	#traits : 'TToSelectInnerContainerElement',
	#classTraits : 'TToSelectInnerContainerElement classTrait',
	#instVars : [
		'selectElement',
		'textInputElement',
		'pickCount'
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

	^ selectElement maxSelectedCount isZero or: [ aNumber <= selectElement maxSelectedCount ]
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
ToMultiSelectBarElement >> checkMaxSelectedCountFromListElement [

	| sM unselectableSM groupeSM maxSelectedCount selectedIndexCount |
	maxSelectedCount := selectElement maxSelectedCount.
	selectElement maxSelectedCount isZero ifTrue: [ ^ self ].

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
	shower := ToMultiSelectCompositeDataItem new.
	shower dataItems:
		(invisibleNodes collect: [ :n | n holder dataItem ]).
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
	pickCount := 0.
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
ToMultiSelectBarElement >> listElement [

	^ selectElement listElement
]

{ #category : #skin }
ToMultiSelectBarElement >> newRawSkin [ 

	^ ToMultiSelectBarElementSkin new
]

{ #category : #accessing }
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
ToMultiSelectBarElement >> onSelectionChangedInSelectElement: anEvent [

	self refresh.
	self requestLayout
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> refresh [
	" first remove all data nodes "

	| sieve previousDataItems newItems |
	self selectElement showHidePlaceholder.

	self selecter deselectAll.
	" copy the previous items "
	previousDataItems := self dataAccessor asOrderedCollection.
	newItems := OrderedCollection new.

	" take care of a possible composite that represents a list of items "
	previousDataItems ifNotEmpty: [
		| last |
		last := previousDataItems last.
		last isComposite ifTrue: [
			previousDataItems removeLast.
			previousDataItems addAll: last dataItems ] ].

	self dataAccessor removeAll.

	sieve := self windowManager sieve.
	sieve selectionModel selectedIndexesDo: [ :idx |
		| new previous |
		new := ToMultiSelectDataItem index: idx.
		previous := previousDataItems
			            detect: [ :item | item index = idx ]
			            ifNone: [  ].
		previous ifNotNil: [ new pickOrder: previous pickOrder ] ifNil: [
			pickCount := pickCount + 1.
			new pickOrder: pickCount ].
		newItems add: new ].

	selectElement keepPickOrder ifTrue: [
		newItems sort: [ :a :b | a pickOrder < b pickOrder ] ].
	self dataAccessor addAll: newItems.

	self checkHideSelectionFromListElement.
	self checkMaxSelectedCountFromListElement
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
