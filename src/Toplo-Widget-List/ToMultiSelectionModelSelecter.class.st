Class {
	#name : #ToMultiSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #operations }
ToMultiSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToRemoveSelectionOperation new).
	self changeCurrentIndexWith: (aStartIndex min: anEndIndex)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToAddSelectionOperation new;
			 yourself).
	self selectionModel itemCount > 0
		ifTrue: [ self changeCurrentIndexWith: 1 ]
		ifFalse: [ self changeCurrentIndexWith: 0 ]
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectAllIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anArray last
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anIndex
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anEndIndex
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectOnlyIndex: anIndex [

	(self selectionModel selectedIndexesCount = 1 and: [
		 self selectionModel firstIndex = anIndex ]) ifTrue: [ ^ self ].
	self addCommand: (ToWholeSelectionCommand new
			 silent: true;
			 operation: ToRemoveSelectionOperation new;
			 yourself).
	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anIndex
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectOnlyIndexes: anArray [

	self addCommand:
		(ToWholeSelectionCommand new operation:
			 ToRemoveSelectionOperation new).
	anArray ifEmpty: [ ^ self ].
	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anArray last
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self selectIndex: curr to: index
]
