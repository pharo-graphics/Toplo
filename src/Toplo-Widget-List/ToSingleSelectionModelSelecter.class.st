Class {
	#name : #ToSingleSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectAll [

	ToInvalidElementCommand signal
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndex: anIndex [

	self addSelectionCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	aStartIndex ~= anEndIndex ifTrue: [ ^ ToInvalidElementCommand signal ].
	self selectIndex: aStartIndex
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndexes: anArray [

	anArray ifEmpty: [ ^ self ].
	anArray size > 1 ifTrue: [ ^ ToInvalidElementCommand signal ].
	self selectIndex: anArray first
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectOnlyIndexes: anArray [

	anArray size > 1 ifTrue: [ ^ ToInvalidElementCommand signal ].
	super selectOnlyIndexes: anArray
]
