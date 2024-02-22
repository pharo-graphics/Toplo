Class {
	#name : #ToSelectSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #operations }
ToSelectSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self deselectIndex: anEndIndex
]

{ #category : #operations }
ToSelectSelectionModelSelecter >> selectAll [
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
ToSelectSelectionModelSelecter >> selectIndexes: anArray [

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
ToSelectSelectionModelSelecter >> selectOnlyIndex: anIndex [

	self selectIndex: anIndex
]

{ #category : #operations }
ToSelectSelectionModelSelecter >> selectOnlyIndexes: anArray [

	| deselCmd |
	deselCmd := ToWholeSelectionCommand new
		            operation: ToRemoveSelectionOperation new;
		            yourself.
	anArray ifEmpty: [
		self addCommand: deselCmd.
		^ self ].
	deselCmd silent: true.
	self addCommand: (ToCompositeCommand new commands: {
				 deselCmd.
				 (ToIndexesSelectionCommand new
					  indexes: anArray;
					  operation: ToAddSelectionOperation new) }).
	self changeCurrentIndexWith: anArray last
]
