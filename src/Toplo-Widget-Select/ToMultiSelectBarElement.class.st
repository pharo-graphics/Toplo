Class {
	#name : #ToMultiSelectBarElement,
	#superclass : #ToTagBarElement,
	#traits : 'TToSelectInnerContainerElement',
	#classTraits : 'TToSelectInnerContainerElement classTrait',
	#instVars : [
		'selectElement',
		'textInputElement',
		'maxSelectedCount',
		'keepPickOrder',
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
	self popupListElement hideSelection
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> checkMaxSelectedCount [

	| sM unselectableSM groupeSM selectedIndexCount |
	maxSelectedCount isZero ifTrue: [ ^ self ].

	unselectableSM := self popupListElement unselectableSelectionModel.
	groupeSM := self popupListElement groupSelectionModel.
	sM := self popupListElement selectionModel.

	selectElement updateSelectedCountLabel.
	selectedIndexCount := self popupListSieve selectionModel
		                      selectedIndexesCount.

	self assertMaxSelectedCount: selectedIndexCount.
	self popupListSieve currentDataWithLocalAndOriginalIndexDo: [
		:d
		:localIndex
		:originalIndex |
		(groupeSM containsIndex: localIndex) ifFalse: [
			selectedIndexCount < maxSelectedCount
				ifTrue: [ unselectableSM deselectIndex: localIndex ]
				ifFalse: [
					(selectElement popupListSelectionModel containsIndex:
						 originalIndex) ifFalse: [
						unselectableSM selectIndex: localIndex ] ] ] ].

	self popupListElement notifyDataSourceChanged
]

{ #category : #initialization }
ToMultiSelectBarElement >> defaultNodeManager [

	^ ToMultiSelectNodeManager new
]

{ #category : #layout }
ToMultiSelectBarElement >> extentChanged [

	super extentChanged.
	self refresh
]

{ #category : #layout }
ToMultiSelectBarElement >> haveInvisibleNodes: theInvisibleNodes [

	| visibleNodes invisibleNodes composite finalCount |
	" in case of composite node at first it means that 
	there is no more visible node to cumulate in a composite node"
	self nodes size = 1 ifTrue: [ ^ self ].

	visibleNodes := self nodesSelect: [ :n | n isFullyVisible ].
	invisibleNodes := theInvisibleNodes copy.
	visibleNodes ifNotEmpty: [
		invisibleNodes := theInvisibleNodes copyWith: visibleNodes last.
		visibleNodes := visibleNodes copyWithout: visibleNodes last ].
	" now cumulate invisible nodes in a composite holder "
	composite := ToCompositeTagModel new.
	composite items: (Array streamContents: [ :stream |
			 invisibleNodes do: [ :n |
				 stream nextPutAll: n holder dataItem items ] ]).
	finalCount := self nodesCount - visibleNodes size.
	composite content: '+ ' , finalCount asString , ' ...'.
	invisibleNodes do: [ :node |
		self dataAccessor removeAt: node holder position ].
	self dataAccessor add: composite
]

{ #category : #initialization }
ToMultiSelectBarElement >> initialize [

	super initialize.
	maxSelectedCount := 0.
	keepPickOrder := false.
	pickCount := 0.

	self installTextInputElement
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

	self
		deprecated: 'Use #popupListElement'
		transformWith: '`@rcvr listElement' -> '`@rcvr popupListElement'.

	^ self popupListElement
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

{ #category : #accessing }
ToMultiSelectBarElement >> popupListElement [


	^ selectElement popupListElement
]

{ #category : #accessing }
ToMultiSelectBarElement >> popupListSieve [

	^ selectElement popupListSieve
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
	selectElement popupListSelectionModel selectedIndexesDo: [ :idx |
		| new previous |
		previous := previousItems
			            detect: [ :item | item data = (selectElement popupListSieve originalData at: idx) ]
			            ifNone: [  ].
		previous
			ifNotNil: [
				new := previous.
				previousItems remove: previous ]
			ifNil: [
				new := ToPickedTagModel new
					       data: (selectElement popupListSieve originalData at: idx);
					       yourself.
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

	self
		deprecated: 'Use #popupListSieve'
		transformWith: '`@rcvr sieve' -> '`@rcvr popupListSieve'.

	^ self popupListSieve
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> textInputElement [ 

	^ textInputElement 
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> textInputElementClass [

	^ ToMultiSelectTextInputElement
]
