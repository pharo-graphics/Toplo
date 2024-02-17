Class {
	#name : #ToSelectSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #operations }
ToSelectSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self deselectIndex: anEndIndex
]

{ #category : #operations }
ToSelectSelectionModelSelecter >> selectAll [
]

{ #category : #operations }
ToSelectSelectionModelSelecter >> selectAllIndexes: anArray [

	| indexes |
	self class name trace.
	' selectAllIndexes:' traceCr.
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
ToSelectSelectionModelSelecter >> selectIndex: anIndex [

	self selectionModel ifNotEmpty: [
		self selectionModel firstIndex = anIndex ifTrue: [ ^ self ] ].
	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anIndex
]

{ #category : #operations }
ToSelectSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self selectIndex: anEndIndex
]

{ #category : #operations }
ToSelectSelectionModelSelecter >> selectOnlyIndex: anIndex [

	self selectIndex: anIndex
]

{ #category : #operations }
ToSelectSelectionModelSelecter >> selectOnlyIndexes: anArray [

	self class name trace.
	' selectOnlyIndexes: ' trace.
	anArray traceCr.
	self deselectAll.
	anArray ifEmpty: [ ^ self ].
	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anArray last
]

{ #category : #operations }
ToSelectSelectionModelSelecter >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self selectIndex: index
]
