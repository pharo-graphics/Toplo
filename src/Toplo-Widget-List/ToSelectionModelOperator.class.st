Class {
	#name : #ToSelectionModelOperator,
	#superclass : #ToListElementOperator,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #operations }
ToSelectionModelOperator >> deselectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelOperator >> deselectAllIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> deselectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #'event dispatching' }
ToSelectionModelOperator >> dispatchEventForCommandOn: anEventTarget [

	| request |
	anEventTarget dispatchEvent: (request := ToSelectionRequestEvent new
			            command: command;
			            yourself).
	dispatchChanges ifFalse: [ ^ self ].
	request selectionChanged ifTrue: [
		anEventTarget dispatchEvent: (ToListSelectionChangedEvent new selectionModel: anEventTarget selectionModel copy; yourself)].
	anEventTarget dispatchEvent: (ToAppliedSelectionEvent new
			 selectionChanged: request selectionChanged;
			 command: command)
]

{ #category : #operations }
ToSelectionModelOperator >> selectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelOperator >> selectAllIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> selectIndex: anIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: anIndex to: anIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> selectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> selectOnlyIndex: anIndex [

	self addCommand: ((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIntervalSelectionCommand new
				  from: anIndex to: anIndex;
				  operation: ToAddSelectionOperation new))
]

{ #category : #operations }
ToSelectionModelOperator >> selectOnlyIndexes: anArray [

	self addCommand: ((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIndexesSelectionCommand new
				  indexes: anArray;
				  operation: ToAddSelectionOperation new))
]
