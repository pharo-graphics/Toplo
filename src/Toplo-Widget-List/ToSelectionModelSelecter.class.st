Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #ToAbstractSelectionModelSelecter,
	#instVars : [
		'currentIndex',
		'operator',
		'operateSilently'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #adding }
ToSelectionModelSelecter >> addCommand: aCommand [

	aCommand silent ifFalse: [aCommand silent: self operateSilently ].
	self operator addCommand: aCommand
]

{ #category : #accessing }
ToSelectionModelSelecter >> beSilentWhile: aBlock [

	| prev |
	prev := operateSilently.
	operateSilently := true.
	[ aBlock cull: self ] ensure: [ operateSilently := prev ] 
]

{ #category : #operations }
ToSelectionModelSelecter >> changeCurrentIndexWith: anIndex [

	self currentIndex: anIndex
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself).
	self changeCurrentIndexWith: 0
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new).
	self changeCurrentIndexWith: 0
]

{ #category : #accessing }
ToSelectionModelSelecter >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #private }
ToSelectionModelSelecter >> nextDeselectedIndex [

	^ self sideIdx: 1
]

{ #category : #private }
ToSelectionModelSelecter >> nextSelectableIndex [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ 0 ].
			^ 1 ]
		ifFalse: [ self currentIndex < self itemCount ifFalse: [ ^ 1 ] ].
	^ self currentIndex + 1
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	operator := ToSelectionModelOperator new.
	operator onInstalledIn: anEventTarget.
		currentIndex := 0
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onUninstalledIn: anEventTarget [

	super onUninstalledIn: anEventTarget.
	operator onUninstalledIn: anEventTarget.
	operator := nil.
	currentIndex := 0
]

{ #category : #accessing }
ToSelectionModelSelecter >> operateSilently [

	^ operateSilently 
]

{ #category : #accessing }
ToSelectionModelSelecter >> operator [

	^ operator
]

{ #category : #private }
ToSelectionModelSelecter >> previousDeselectedIndex [

	^ self sideIdx: -1
]

{ #category : #private }
ToSelectionModelSelecter >> previousSelectableIndex [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ 0 ].
			^ self itemCount ]
		ifFalse: [ self currentIndex > 1 ifFalse: [ ^ self itemCount ] ].
	^ self currentIndex - 1
]

{ #category : #operations }
ToSelectionModelSelecter >> scrollToIndex: anIndex [

	self itemCount >= anIndex ifTrue: [
		self addCommand: (ToListScrollCommand new
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new).
	self changeCurrentIndexWith: anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndex: anIndex [

	(self selectionModel selectedIndexesCount = 1 and: [
		 self selectionModel firstIndex = anIndex ]) ifTrue: [ ^ self ].
	self addCommand: (ToCompositeCommand new commands: {
				 (ToWholeSelectionCommand new
					  silent: true;
					  operation: ToRemoveSelectionOperation new;
					  yourself).
				 (ToIntervalSelectionCommand new
					  from: anIndex to: anIndex;
					  operation: ToAddSelectionOperation new) }).
	self changeCurrentIndexWith: anIndex
]

{ #category : #accessing }
ToSelectionModelSelecter >> selectionModel [

	^ self operator selectionModel
]

{ #category : #operations }
ToSelectionModelSelecter >> shiftSelection: anInteger from: anIndex [

	self addCommand: (ToSelectionModelShiftCommand new
			 itemCount: anInteger;
			 fromIndex: anIndex;
			 yourself)
]

{ #category : #private }
ToSelectionModelSelecter >> sideIdx: aGap [

	| nextIdx |
	nextIdx := self currentIndex.
	(self selectionModel containsIndex: nextIdx) ifFalse: [ ^ nextIdx ].
	[
	(nextIdx between: 1 and: self itemCount) and: [
		self selectionModel containsIndex: nextIdx ] ] whileTrue: [
		nextIdx := nextIdx + aGap ].
	nextIdx := (nextIdx max: 1) min: self itemCount.
	^ nextIdx
]
