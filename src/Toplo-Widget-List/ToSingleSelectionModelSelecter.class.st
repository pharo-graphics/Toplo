Class {
	#name : #ToSingleSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #operations }
ToSingleSelectionModelSelecter >> deselectIndex: anIndex [

	self operator addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectAll [
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectAllIndexes: anArray [

	| indexes |
	indexes := anArray size > 1
		           ifTrue: [ anArray copyFrom: 1 to: 1 ]
		           ifFalse: [ anArray ].
	self operator addCommand: (ToIndexesSelectionCommand new
			 indexes: indexes;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectAndScrollToIndex: anIndex [

	self selectIndex: anIndex.
	self operator applyAll.
	self operator selectionModel ifNotEmpty: [
		self operator addCommand: (ToActionCommand new
				 action: [ :e | e scrollToIndex: anIndex ];
				 yourself) ]
]

{ #category : #'shortcuts operations' }
ToSingleSelectionModelSelecter >> selectAndScrollToNext [

	| nextIdx |
	nextIdx := self operator nextIdxTowardEnd.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self operator applyAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToSingleSelectionModelSelecter >> selectAndScrollToNextDeselected [

	self selectAndScrollToIndex: (self operator sideIdx: 1)
]

{ #category : #'shortcuts operations' }
ToSingleSelectionModelSelecter >> selectAndScrollToPrevious [

	| nextIdx |
	nextIdx := self operator nextIdxTowardStart.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToSingleSelectionModelSelecter >> selectAndScrollToPreviousDeselected [

	self selectAndScrollToIndex: (self operator sideIdx: -1)
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndex: anIndex [

	self deselectAll.
	self operator addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self selectIndex: anEndIndex
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectOnlyIndex: anIndex [

	self selectIndex: anIndex
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectOnlyIndexes: anArray [

	| indexes |
	indexes := anArray size > 1
		           ifTrue: [ anArray copyFrom: 1 to: 1 ]
		           ifFalse: [ anArray ].
	self deselectAll.
	self operator addCommand: (ToIndexesSelectionCommand new
			 indexes: indexes;
			 operation: ToAddSelectionOperation new)
]

{ #category : #'shortcuts operations' }
ToSingleSelectionModelSelecter >> selectToIndex: index [

	| curr |
	curr := self operator currentIndex.
	self selectIndex: index
]
