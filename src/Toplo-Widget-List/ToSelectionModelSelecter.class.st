Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #ToAbstractSelectionModelSelecter,
	#instVars : [
		'operator'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToSelectionModelSelecter >> beSilentWhile: aBlock [ 

	self operator beSilentWhile: aBlock 
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex [ 

	^ self operator currentIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAll [

	self operator addCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAllIndexes: anArray [

	self operator addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: anIndex [

	self operator addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	operator := ToSelectionModelOperator new.
	operator onInstalledIn: anEventTarget
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onUninstalledIn: anEventTarget [

	super onUninstalledIn: anEventTarget.
	operator onUninstalledIn: anEventTarget.
	operator := nil
]

{ #category : #accessing }
ToSelectionModelSelecter >> operator [

	^ operator
]

{ #category : #operations }
ToSelectionModelSelecter >> selectAndScrollToIndex: anIndex [

	self selectIndex: anIndex.
	self operator selectionModel ifNotEmpty: [
		self operator addCommand: (ToActionCommand new
				 action: [ :e | e scrollToIndex: anIndex ];
				 yourself) ]
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectAndScrollToNext [

	| nextIdx |
	nextIdx := self operator nextIdxTowardEnd.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectAndScrollToNextDeselected [

	self selectAndScrollToIndex: (self operator sideIdx: 1)
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectAndScrollToPrevious [

	| nextIdx |
	nextIdx := self operator nextIdxTowardStart.
	nextIdx isZero ifTrue: [ ^ self ].
	self deselectAll.
	self selectAndScrollToIndex: nextIdx
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectAndScrollToPreviousDeselected [

	self selectAndScrollToIndex: (self operator sideIdx: -1)
]
