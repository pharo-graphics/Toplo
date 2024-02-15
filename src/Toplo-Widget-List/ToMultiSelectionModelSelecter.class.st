Class {
	#name : #ToMultiSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #operations }
ToMultiSelectionModelSelecter >> deselectIndex: anIndex [

	self operator addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectAll [

	self operator addCommand: (ToWholeSelectionCommand new
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectAllIndexes: anArray [

	self operator addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectAndScrollToIndex: anIndex [

	self selectIndex: anIndex.
	self operator applyAll.
	self operator selectionModel ifNotEmpty: [
		self operator addCommand: (ToActionCommand new
				 action: [ :e | e scrollToIndex: anIndex ];
				 yourself) ]
]

{ #category : #'shortcuts operations' }
ToMultiSelectionModelSelecter >> selectAndScrollToNext [

	| nextIdx |
	nextIdx := self operator nextIdxTowardEnd.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self operator applyAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToMultiSelectionModelSelecter >> selectAndScrollToNextDeselected [

	self selectAndScrollToIndex: (self operator sideIdx: 1)
]

{ #category : #'shortcuts operations' }
ToMultiSelectionModelSelecter >> selectAndScrollToPrevious [

	| nextIdx |
	nextIdx := self operator nextIdxTowardStart.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToMultiSelectionModelSelecter >> selectAndScrollToPreviousDeselected [

	self selectAndScrollToIndex: (self operator sideIdx: -1)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectIndex: anIndex [

	self operator addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self operator addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectOnlyIndex: anIndex [

	self operator addCommand:
		(ToWholeSelectionCommand new operation:
			 ToRemoveSelectionOperation new).
	self operator addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectOnlyIndexes: anArray [

	self operator addCommand:
		(ToWholeSelectionCommand new operation:
			 ToRemoveSelectionOperation new).
	self operator addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #'shortcuts operations' }
ToMultiSelectionModelSelecter >> selectToIndex: index [

	| curr |
	curr := self operator currentIndex.
	self selectIndex: curr to: index
]
