Class {
	#name : #ToSingleSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectAll [

	ToInvalidCommand signal
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself)).
	self changeCurrentIndexWith: anIndex
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	aStartIndex ~= anEndIndex ifTrue: [ ^ ToInvalidCommand signal ].
	self selectIndex: aStartIndex
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndexes: anArray [

	anArray ifEmpty: [ ^ self ].
	anArray size > 1 ifTrue: [ ^ ToInvalidCommand signal ].
	self selectIndex: anArray first
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectOnlyIndexes: anArray [

	anArray size > 1 ifTrue: [ ^ ToInvalidCommand signal ].
	super selectOnlyIndexes: anArray
]
