Class {
	#name : #ToSingleSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #operations }
ToSingleSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self deselectIndex: anEndIndex
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectAll [
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectAllIndexes: anArray [

	| indexes |
	anArray ifEmpty: [ ^ self ].
	indexes := anArray size > 1
		           ifTrue: [ anArray copyFrom: 1 to: 1 ]
		           ifFalse: [ anArray ].
	self addCommand: (ToIndexesSelectionCommand new
			 indexes: indexes;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: indexes last
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndex: anIndex [

	self selectionModel firstIndex = anIndex ifTrue: [ ^ self ].
	self beSilentWhile: [ self deselectAll ].
	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anIndex
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
	self deselectAll.
	anArray ifEmpty: [ ^ self ].
	indexes := anArray size > 1
		           ifTrue: [ anArray copyFrom: 1 to: 1 ]
		           ifFalse: [ anArray ].
	self addCommand: (ToIndexesSelectionCommand new
			 indexes: indexes;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anArray last
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self selectIndex: index
]
