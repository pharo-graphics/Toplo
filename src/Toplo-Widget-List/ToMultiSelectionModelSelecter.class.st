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
ToMultiSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anEndIndex
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new).
	anArray ifEmpty: [
		self changeCurrentIndexWith: 0.
		^ self ].
	self changeCurrentIndexWith: anArray last
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectOnlyIndexes: anArray [

	anArray ifEmpty: [ 
		self addCommand:
			(ToWholeSelectionCommand new operation:
				 ToRemoveSelectionOperation new).
		self changeCurrentIndexWith: 0.
		^ self ].
	self addCommand: (ToCompositeCommand new commands: {
				 (ToWholeSelectionCommand new
					  silent: true;
					  operation: ToRemoveSelectionOperation new).
				 (ToIndexesSelectionCommand new
					  indexes: anArray;
					  operation: ToAddSelectionOperation new) }).
	self changeCurrentIndexWith: anArray last
]
