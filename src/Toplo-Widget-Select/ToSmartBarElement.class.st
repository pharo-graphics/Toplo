Class {
	#name : #ToSmartBarElement,
	#superclass : #ToBarElement,
	#instVars : [
		'pickCount',
		'maxSelectedCount',
		'keepPickOrder'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToSmartBarElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #'accessing - selection' }
ToSmartBarElement >> allowSelectedCount: aNumber [

	^ maxSelectedCount isZero or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToSmartBarElement >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToSmartBarElement >> checkMaxSelectedCount [

	maxSelectedCount isZero ifTrue: [ ^ self ].
	self updateSelectedCountLabel
]

{ #category : #initialization }
ToSmartBarElement >> defaultEventHandler [ 

	^ ToMultiSelectBarEventHandler new
]

{ #category : #initialization }
ToSmartBarElement >> defaultNodeManager [

	^ ToMultiSelectBarNodeManager new
]

{ #category : #layout }
ToSmartBarElement >> haveFullyInvisibleNodes: theInvisibleNodes [

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
ToSmartBarElement >> initialize [

	super initialize.
	
	" no visible primary and secondary selection elements "
	self primarySelectionMode option masked: true.
	self secondarySelectionMode option masked: true.

	pickCount := 0.
	" mandatory resizer setting. 
	Normally, should not be changed"
	self vFitContent.
	self hMatchParent 
]

{ #category : #'t - select inner container' }
ToSmartBarElement >> isMultipleSelection [ 

	^ true
]

{ #category : #skin }
ToSmartBarElement >> newRawSkin [ 

	^ ToMultiSelectBarElementSkin new
]

{ #category : #'t - children - accessing' }
ToSmartBarElement >> nodes [

	^ self innerContainer nodes
]

{ #category : #accessing }
ToSmartBarElement >> nodesCount [

	| count |
	count := 0.
	self nodesDo: [ :node |
		count := count + node nodesCount ].
	^ count
]

{ #category : #accessing }
ToSmartBarElement >> nodesDo: aBlock [

	self innerContainer nodesDo: aBlock
]

{ #category : #accessing }
ToSmartBarElement >> nodesSelect: aBlock [

	^ self innerContainer nodesSelect: aBlock
]

{ #category : #'t - select inner container' }
ToSmartBarElement >> refresh [
	" first remove all data nodes "

	| previousItems newItems |
	self showHidePlaceholder.

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
	self selectionModel selectedIndexesDo: [ :idx |
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
	self checkMaxSelectedCount
]

{ #category : #'t - select inner container' }
ToSmartBarElement >> textInputElementClass [

	^ ToMultiSelectTextInputElement
]
