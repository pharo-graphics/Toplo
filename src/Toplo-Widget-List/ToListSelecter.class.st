Class {
	#name : #ToListSelecter,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'element',
		'enabled',
		'operator',
		'multiple',
		'eventDispatcher',
		'selectionChangedEventClass',
		'selectionMode',
		'selectionModel',
		'commandApplicationStrategy'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'command application' }
ToListSelecter >> addCommand: aCommand [

	enabled ifFalse: [ ^ self ].
	commandApplicationStrategy addCommand: aCommand 
]

{ #category : #'command application' }
ToListSelecter >> applyCommand: aCommand [

	| previousModel |
	aCommand selectionModel: selectionModel.
	previousModel := selectionModel copy.
	aCommand applyWithOperator: operator.
	previousModel = aCommand selectionModel ifTrue: [ ^ self ].
	self onCommandApplied: aCommand
]

{ #category : #accessing }
ToListSelecter >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToListSelecter >> beSingleSelection [

	self multiple: false
]

{ #category : #accessing }
ToListSelecter >> commandApplicationStrategy: aCommandApplicationStrategy [

	commandApplicationStrategy := aCommandApplicationStrategy
]

{ #category : #testing }
ToListSelecter >> containsIndex: anIndex [

	^ self selectionModel containsIndex: anIndex
]

{ #category : #copying }
ToListSelecter >> copySelectionFrom: aSourceSelectionModel [

	self addCommand: (ToSelectionCopyFromCommand new
			 sourceSelectionModel: aSourceSelectionModel;
			 yourself)
]

{ #category : #accessing }
ToListSelecter >> currentIndex [

	^ enabled
		  ifFalse: [ 0 ]
		  ifTrue: [ operator currentIndex ]
]

{ #category : #initialization }
ToListSelecter >> defaultCommandApplicationStrategy [

	^ ToQueueBasedCommandApplicationStrategy new
]

{ #category : #operations }
ToListSelecter >> deselectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToListSelecter >> deselectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToListSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToListSelecter >> deselectIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #protocol }
ToListSelecter >> disable [

	self enabled: false
]

{ #category : #accessing }
ToListSelecter >> element [

	^ element

]

{ #category : #protocol }
ToListSelecter >> enable [

	self enabled: true
]

{ #category : #accessing }
ToListSelecter >> enabled [

	^ enabled
]

{ #category : #accessing }
ToListSelecter >> enabled: aBoolean [

	enabled = aBoolean ifTrue: [ ^ self ].
	enabled := aBoolean.
	self updateSelection
]

{ #category : #'event management accessing' }
ToListSelecter >> eventDispatcher [
	"Return an object responsible for event dispatching"

	<return: #BlDirectEventDispatcher>
	^ eventDispatcher ifNil: [
		  eventDispatcher := BlDirectEventDispatcher on: self ]
]

{ #category : #initialization }
ToListSelecter >> initialize [ 

	super initialize.
	multiple := true.
	enabled := true.
	operator := ToSelectionModelOperator new.
	commandApplicationStrategy := self defaultCommandApplicationStrategy 
]

{ #category : #testing }
ToListSelecter >> isMultipleSelection [

	^ self multiple
]

{ #category : #testing }
ToListSelecter >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #accessing }
ToListSelecter >> itemCount [

	^ selectionModel itemCount
]

{ #category : #accessing }
ToListSelecter >> multiple [

	^ multiple
]

{ #category : #accessing }
ToListSelecter >> multiple: aBoolean [

	multiple = aBoolean ifTrue: [ ^ self ].
	multiple := aBoolean.
	self updateSelection 
]

{ #category : #private }
ToListSelecter >> nextDeselectedIndex [

	^ self sideIdx: 1
]

{ #category : #private }
ToListSelecter >> nextSelectableIndex [

	enabled ifFalse: [ ^ 0 ].

	^ self currentIndex isZero
		  ifTrue: [
			  selectionModel itemCount isZero
				  ifTrue: [ 0 ]
				  ifFalse: [ self nextSelectableIndexStartingAt: 1 ] ]
		  ifFalse: [
			  | next |
			  next := self nextSelectableIndexStartingAt: self currentIndex + 1.
			  next isZero
				  ifTrue: [ self nextSelectableIndexStartingAt: 1 ]
				  ifFalse: [ next ] ]
]

{ #category : #private }
ToListSelecter >> nextSelectableIndexStartingAt: anIndex [

	^ selectionModel nextSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToListSelecter >> nextSelectableIndexToScrollTo [

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

{ #category : #'command application' }
ToListSelecter >> onCommandApplied: aCommand [

	| req |
	selectionChangedEventClass ifNil: [ ^ self ].

	req := ToListSelectionCommandAppliedEvent new
		       command: aCommand;
		       requestedAction: [
			       element dispatchEvent: (selectionChangedEventClass new
						        selectionModel: aCommand selectionModel;
						        touchedIntervals: aCommand intervals;
						        selectionOption: self selectionOption;
						        yourself) ];
		       yourself.

	element dispatchAuthorisationRequest: req
]

{ #category : #'api - hooks' }
ToListSelecter >> onInstalledIn: anElement [

	element := anElement.
	selectionModel on: anElement.
	commandApplicationStrategy commandApplier: self element: element
]

{ #category : #'api - hooks' }
ToListSelecter >> onUninstalledIn: anElement [

	commandApplicationStrategy := nil.
	element := nil
]

{ #category : #accessing }
ToListSelecter >> operator [

	^ operator
]

{ #category : #accessing }
ToListSelecter >> operator: aSelectionModelOperator [

	operator := aSelectionModelOperator
]

{ #category : #private }
ToListSelecter >> previousDeselectedIndex [

	^ self sideIdx: -1
]

{ #category : #private }
ToListSelecter >> previousSelectableIndex [

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
ToListSelecter >> previousSelectableIndexStartingAt: anIndex [

	^ selectionModel previousSelectableIndexStartingAt: anIndex
]

{ #category : #private }
ToListSelecter >> previousSelectableIndexToScrollTo [

	| prev |
	prev := self previousSelectableIndex.
	" not exactly on the first selectable position -> just return the previous index else, return self itemCount or 0"
	^ self currentIndex > (self nextSelectableIndexStartingAt: 1)
		  ifTrue: [ prev ]
		  ifFalse: [ selectionModel itemCount max: 0 ]
]

{ #category : #operations }
ToListSelecter >> scrollToDataSourcePosition: anIndex [

	enabled ifFalse: [ ^ self ].
	selectionModel itemCount >= anIndex ifTrue: [
		self addCommand: (ToScrollCommand new
				 target: element;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToListSelecter >> scrollToIndex: anIndex [

	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndex: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.

	self scrollToDataSourcePosition: anIndex
]

{ #category : #operations }
ToListSelecter >> scrollTowardEndToDataSourcePosition: anIndex [

	enabled ifFalse: [ ^ self ].
	selectionModel itemCount >= anIndex ifTrue: [
		self addCommand: (ToScrollCommand new
				 towardEnd: true;
				 target: element;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToListSelecter >> scrollTowardStartToDataSourcePosition: anIndex [

	enabled ifFalse: [ ^ self ].
	selectionModel itemCount >= anIndex ifTrue: [
		self addCommand: (ToScrollCommand new
				 towardEnd: false;
				 target: element;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToListSelecter >> selectAll [

	self isMultipleSelection ifFalse: [ ToInvalidElementCommand signal ].
	self addCommand: (ToWholeSelectionCommand new
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToListSelecter >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: self isSingleSelection;
					  yourself))
]

{ #category : #operations }
ToListSelecter >> selectIndex: aStartIndex to: anEndIndex [

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
ToListSelecter >> selectIndexes: anArray [

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
ToListSelecter >> selectOnlyIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: (ToAddSelectionOperation new
					  deselectAllBefore: true;
					  yourself))
]

{ #category : #operations }
ToListSelecter >> selectOnlyIndexes: anArray [

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
ToListSelecter >> selectedIndexes [

	^ self selectionModel selectedIndexes
]

{ #category : #accessing }
ToListSelecter >> selectionChangedEventClass [

	^ selectionChangedEventClass
]

{ #category : #accessing }
ToListSelecter >> selectionChangedEventClass: anEventClass [

	selectionChangedEventClass := anEventClass
]

{ #category : #accessing }
ToListSelecter >> selectionMode: aSelectionMode [

	selectionMode := aSelectionMode
]

{ #category : #accessing }
ToListSelecter >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelecter >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel 
]

{ #category : #accessing }
ToListSelecter >> selectionOption [

	^ selectionMode ifNotNil: [ :sm | sm selectionOption ]
]

{ #category : #operations }
ToListSelecter >> shiftSelection: anInteger from: anIndex [

	self addCommand: (ToSelectionShiftCommand new
			 itemCount: anInteger;
			 fromIndex: anIndex;
			 yourself)
]

{ #category : #private }
ToListSelecter >> sideIdx: aGap [

	^ enabled ifFalse: [ 0 ] ifTrue: [ selectionModel sideIdx: aGap startingAt: self currentIndex ]
]

{ #category : #operations }
ToListSelecter >> switchIndexSelection: anIndex [

	(self containsIndex: anIndex)
		ifTrue: [ self deselectIndex: anIndex ]
		ifFalse: [ self selectIndex: anIndex ]
]

{ #category : #accessing }
ToListSelecter >> updateSelection [

	self selectionModel deselectAll.
	element ifNil: [ ^ self ].
	element updateAllSelections
]
