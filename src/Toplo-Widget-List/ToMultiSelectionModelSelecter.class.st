Class {
	#name : #ToMultiSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

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
