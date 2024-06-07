Class {
	#name : #ToListElementSelecter,
	#superclass : #Object,
	#instVars : [
		'eventTarget',
		'enabled',
		'operator',
		'selectionModel',
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #adding }
ToListElementSelecter >> addCommand: aCommand [

	enabled ifFalse: [ ^ self ].
	self applyCommand: aCommand
]

{ #category : #'command application' }
ToListElementSelecter >> applyCommand: aCommand [

	| previousModel |
	aCommand selectionModel: selectionModel.
	previousModel := selectionModel copy.
	aCommand applyWithOperator: operator.
	previousModel = aCommand selectionModel ifTrue: [ ^ self ].
	self commandApplied: aCommand
]

{ #category : #accessing }
ToListElementSelecter >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToListElementSelecter >> beSingleSelection [

	self multiple: false
]

{ #category : #'command application' }
ToListElementSelecter >> commandApplied: aCommand [

	self subclassResponsibility 
]

{ #category : #testing }
ToListElementSelecter >> containsIndex: anIndex [

	^ self selectionModel containsIndex: anIndex
]

{ #category : #copying }
ToListElementSelecter >> copySelectionFrom: aSourceSelectionModel [

	self addCommand: (ToSelectionModelCopyFromCommand new
			 sourceSelectionModel: aSourceSelectionModel;
			 yourself)
]

{ #category : #accessing }
ToListElementSelecter >> currentIndex [

	^ enabled
		  ifFalse: [ 0 ]
		  ifTrue: [ operator currentIndex ]
]

{ #category : #operations }
ToListElementSelecter >> deselectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToListElementSelecter >> deselectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> deselectIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #protocol }
ToListElementSelecter >> disable [

	self enabled: false
]

{ #category : #protocol }
ToListElementSelecter >> enable [

	self enabled: true
]

{ #category : #accessing }
ToListElementSelecter >> enabled [

	^ enabled
]

{ #category : #accessing }
ToListElementSelecter >> enabled: aBoolean [

	enabled = aBoolean ifTrue: [ ^ self ].
	enabled := aBoolean.
	eventTarget ifNil: [ ^ self ].
	eventTarget dispatchEvent: ToSelecterChangedEvent new.


]

{ #category : #accessing }
ToListElementSelecter >> eventTarget: anEventTarget [

	eventTarget := anEventTarget 
]

{ #category : #initialization }
ToListElementSelecter >> initialize [ 

	super initialize.
	multiple := true.
	enabled := true
]

{ #category : #testing }
ToListElementSelecter >> isMultipleSelection [

	^ self multiple
]

{ #category : #testing }
ToListElementSelecter >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #accessing }
ToListElementSelecter >> itemCount [

	^ selectionModel itemCount
]

{ #category : #accessing }
ToListElementSelecter >> multiple [

	^ multiple
]

{ #category : #accessing }
ToListElementSelecter >> multiple: aBoolean [

	multiple = aBoolean ifTrue: [ ^ self ].
	multiple := aBoolean.
	eventTarget ifNil: [ ^ self ].
	eventTarget dispatchEvent: ToSelecterChangedEvent new
]

{ #category : #private }
ToListElementSelecter >> nextDeselectedIndex [

	^ self sideIdx: 1
]

{ #category : #private }
ToListElementSelecter >> nextSelectableIndex [

	enabled ifFalse: [ ^ 0 ].
	self currentIndex isZero
		ifTrue: [
			selectionModel itemCount isZero ifTrue: [ ^ 0 ].
			^ self nextSelectableIndexStartingAt: 1 ]
		ifFalse: [
			self currentIndex
			< (self previousSelectableIndexStartingAt: selectionModel itemCount)
				ifFalse: [ ^ self nextSelectableIndexStartingAt: 1 ] ].
	^ self nextSelectableIndexStartingAt: self currentIndex + 1
]

{ #category : #private }
ToListElementSelecter >> nextSelectableIndexStartingAt: anIndex [

	^ selectionModel nextSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToListElementSelecter >> nextSelectableIndexToScrollTo [

	| next |
	next := self nextSelectableIndex.
	" not on the last selectable position -> just return the next index else, return 1 or 0"
	^ self currentIndex < (self previousSelectableIndexStartingAt: selectionModel itemCount)
		  ifTrue: [ next ]
		  ifFalse: [
			  selectionModel itemCount > 0
				  ifTrue: [ 1 ]
				  ifFalse: [ 0 ] ]
]

{ #category : #'api - hooks' }
ToListElementSelecter >> onInstalledIn: anEventTarget [
	" the argument is passed as the target of commands.
	It receives the selection change event after the application of commands "

	eventTarget := anEventTarget
]

{ #category : #'api - hooks' }
ToListElementSelecter >> onUninstalledIn: anEventTarget [

	eventTarget := nil
]

{ #category : #accessing }
ToListElementSelecter >> operator [

	^ operator
]

{ #category : #accessing }
ToListElementSelecter >> operator: aSelectionModelOperator [

	operator := aSelectionModelOperator
]

{ #category : #private }
ToListElementSelecter >> previousDeselectedIndex [

	^ self sideIdx: -1
]

{ #category : #private }
ToListElementSelecter >> previousSelectableIndex [

	enabled ifFalse: [ ^ 0 ].
	self currentIndex isZero
		ifTrue: [
			selectionModel itemCount isZero ifTrue: [ ^ 0 ].
			^ self previousSelectableIndexStartingAt: selectionModel itemCount ]
		ifFalse: [ self currentIndex > (self nextSelectableIndexStartingAt: 1) 
			ifFalse: [ ^ self previousSelectableIndexStartingAt: selectionModel itemCount ] ].
	^ self previousSelectableIndexStartingAt: self currentIndex - 1
]

{ #category : #private }
ToListElementSelecter >> previousSelectableIndexStartingAt: anIndex [

	^ selectionModel previousSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToListElementSelecter >> previousSelectableIndexToScrollTo [

	| prev |
	prev := self previousSelectableIndex.
	" not exactly on the first selectable position -> just return the previous index else, return self itemCount or 0"
	^ self currentIndex > (self nextSelectableIndexStartingAt: 1)
		  ifTrue: [ prev ]
		  ifFalse: [ selectionModel itemCount max: 0 ]
]

{ #category : #operations }
ToListElementSelecter >> scrollToDataSourcePosition: anIndex [

	enabled ifFalse: [ ^ self ].
	selectionModel itemCount >= anIndex ifTrue: [
		self addCommand: (ToScrollCommand new
				 target: eventTarget;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToListElementSelecter >> scrollToIndex: anIndex [

	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndex: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.

	self scrollToDataSourcePosition: anIndex
]

{ #category : #operations }
ToListElementSelecter >> scrollTowardEndToDataSourcePosition: anIndex [

	enabled ifFalse: [ ^ self ].
	selectionModel itemCount >= anIndex ifTrue: [
		self addCommand: (ToScrollCommand new
				 towardEnd: true;
				 target: eventTarget;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToListElementSelecter >> scrollTowardStartToDataSourcePosition: anIndex [

	enabled ifFalse: [ ^ self ].
	selectionModel itemCount >= anIndex ifTrue: [
		self addCommand: (ToScrollCommand new
				 towardEnd: false;
				 target: eventTarget;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToListElementSelecter >> selectAll [

	self isMultipleSelection ifFalse: [ ToInvalidElementCommand signal ].
	self addCommand: (ToWholeSelectionCommand new
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToListElementSelecter >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: self isSingleSelection;
					  yourself))
]

{ #category : #operations }
ToListElementSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self isSingleSelection ifTrue: [
		aStartIndex ~= anEndIndex ifTrue: [
			^ ToInvalidElementCommand signal ].
		self selectIndex: aStartIndex.
		^ self ].

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> selectIndexes: anArray [

	anArray ifEmpty: [ ^ self ].

	self isSingleSelection ifTrue: [
		anArray size > 1 ifTrue: [ ^ ToInvalidElementCommand signal ].
		self selectIndex: anArray first.
		^ self ].

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToListElementSelecter >> selectOnlyIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #operations }
ToListElementSelecter >> selectOnlyIndexes: anArray [

	self isSingleSelection ifTrue: [
		anArray size > 1 ifTrue: [ ^ ToInvalidElementCommand signal ] ].

	anArray ifEmpty: [
		self addCommand: (ToWholeSelectionCommand new
				 operation: ToRemoveSelectionOperation new).
		^ self ].

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #accessing }
ToListElementSelecter >> selectedIndexes [

	^ self selectionModel selectedIndexes
]

{ #category : #accessing }
ToListElementSelecter >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListElementSelecter >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #operations }
ToListElementSelecter >> shiftSelection: anInteger from: anIndex [

	self addCommand: (ToSelectionModelShiftCommand new
			 itemCount: anInteger;
			 fromIndex: anIndex;
			 yourself)
]

{ #category : #private }
ToListElementSelecter >> sideIdx: aGap [

	^ enabled ifFalse: [ 0 ] ifTrue: [ selectionModel sideIdx: aGap startingAt: self currentIndex ]
]
