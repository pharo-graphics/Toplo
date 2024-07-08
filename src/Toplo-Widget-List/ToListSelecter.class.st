Class {
	#name : #ToListSelecter,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventTarget',
		'enabled',
		'operator',
		'selectionModel',
		'multiple',
		'eventDispatcher',
		'commandApplierEventHandler',
		'selectionChangedEventClass'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'instance creation' }
ToListSelecter class >> additionalNamed: aSymbol inParentSelecter: aParentSelecter withEventClass: anEventClass [

	^ ToAdditionalSelecter new
		  uniqueId: aSymbol;
		  selectionChangedEventClass: anEventClass;
		  parentSelecter: aParentSelecter;
		  yourself
]

{ #category : #adding }
ToListSelecter >> addCommand: aCommand [

	enabled ifFalse: [ ^ self ].
	self dispatchEvent: (ToElementCommandAddedEvent new
			 command: aCommand;
			 yourself)
]

{ #category : #'command application' }
ToListSelecter >> applyCommand: aCommand [

	| previousModel |
	aCommand selectionModel: selectionModel.
	previousModel := selectionModel copy.
	aCommand applyWithOperator: operator.
	previousModel = aCommand selectionModel ifTrue: [ ^ self ].
	self commandApplied: aCommand
]

{ #category : #accessing }
ToListSelecter >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToListSelecter >> beSingleSelection [

	self multiple: false
]

{ #category : #'command application' }
ToListSelecter >> commandApplied: aCommand [

	| req |
	eventTarget dispatchEvent: (ToSelectionCommandAppliedEvent new
			 command: aCommand;
			 yourself).

	req := ToListSelectionChangeRequestEvent new
		       selectionModel: aCommand selectionModel;
		       requestedAction: [
			       eventTarget dispatchEvent: (selectionChangedEventClass new
						        selectionModel: aCommand selectionModel;
						        touchedIndexes: aCommand indexes;
						        touchedIntervals: aCommand intervals;
						        yourself) ];
		       yourself.

	eventTarget dispatchAuthorisationRequest: req
]

{ #category : #accessing }
ToListSelecter >> commandApplierEventHandler: aCommandApplierEventHandler [

	commandApplierEventHandler := aCommandApplierEventHandler
]

{ #category : #testing }
ToListSelecter >> containsIndex: anIndex [

	^ self selectionModel containsIndex: anIndex
]

{ #category : #copying }
ToListSelecter >> copySelectionFrom: aSourceSelectionModel [

	self addCommand: (ToSelectionModelCopyFromCommand new
			 sourceSelectionModel: aSourceSelectionModel;
			 yourself)
]

{ #category : #accessing }
ToListSelecter >> currentIndex [

	^ enabled
		  ifFalse: [ 0 ]
		  ifTrue: [ operator currentIndex ]
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
	eventTarget ifNil: [ ^ self ].
	eventTarget dispatchEvent: ToSelecterChangedEvent new.


]

{ #category : #'event management accessing' }
ToListSelecter >> eventDispatcher [
	"Return an object responsible for event dispatching"

	<return: #BlDirectEventDispatcher>
	^ eventDispatcher ifNil: [
		  eventDispatcher := BlDirectEventDispatcher on: self ]
]

{ #category : #accessing }
ToListSelecter >> eventTarget: anEventTarget [

	eventTarget := anEventTarget 
]

{ #category : #initialization }
ToListSelecter >> initialize [ 

	super initialize.
	multiple := true.
	enabled := true.
	operator := ToSelectionModelOperator new.
	self initializeCommandApplier
]

{ #category : #initialization }
ToListSelecter >> initializeCommandApplier [

	commandApplierEventHandler := ToDataSourceCommandApplierEventHandler new.
	"commandApplierEventHandler := ToDirectCommandApplierEventHandler new."
	"commandApplierEventHandler := ToQueueBasedCommandApplierEventHandler new"
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
	eventTarget ifNil: [ ^ self ].
	eventTarget dispatchEvent: ToSelecterChangedEvent new
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

{ #category : #'api - hooks' }
ToListSelecter >> onInstalledIn: anEventTarget [
	" the argument is passed as the target of commands.
	It receives the selection change event after the application of commands "

	eventTarget := anEventTarget.
	commandApplierEventHandler element: anEventTarget.
	self addEventHandler: commandApplierEventHandler
]

{ #category : #'api - hooks' }
ToListSelecter >> onUninstalledIn: anEventTarget [

	eventTarget := nil.
	self removeEventHandler: commandApplierEventHandler.
	commandApplierEventHandler := nil
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
				 target: eventTarget;
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
				 target: eventTarget;
				 index: anIndex;
				 yourself) ]
]

{ #category : #operations }
ToListSelecter >> scrollTowardStartToDataSourcePosition: anIndex [

	enabled ifFalse: [ ^ self ].
	selectionModel itemCount >= anIndex ifTrue: [
		self addCommand: (ToScrollCommand new
				 towardEnd: false;
				 target: eventTarget;
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

	selectionChangedEventClass ifNotNil: [ BlImmutableObjectChangeError signal ].
	selectionChangedEventClass := anEventClass
]

{ #category : #accessing }
ToListSelecter >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelecter >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #operations }
ToListSelecter >> shiftSelection: anInteger from: anIndex [

	self addCommand: (ToSelectionModelShiftCommand new
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
