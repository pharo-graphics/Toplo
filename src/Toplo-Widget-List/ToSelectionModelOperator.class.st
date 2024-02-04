Class {
	#name : #ToSelectionModelOperator,
	#superclass : #Object,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventTarget'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToSelectionModelOperator >> dataSource [

	^ self eventTarget dataSource
]

{ #category : #operations }
ToSelectionModelOperator >> deselectAll [

	self dispatchEventForCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelOperator >> deselectAllIndexes: anArray [

	self dispatchEventForCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> deselectIndex: anIndex [

	self dispatchEventForCommand: (ToIntervalSelectionCommand new
			 interval: (anIndex to: anIndex);
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #'event dispatching' }
ToSelectionModelOperator >> dispatchCommandResult: aCommand [

	self eventTarget dispatchEvent: (ToSelectionResultEvent new command: aCommand)
]

{ #category : #'event dispatching' }
ToSelectionModelOperator >> dispatchEventForCommand: aCommand [

	| request |
	[
	self eventTarget dispatchEvent:
		(request := ToSelectionRequestEvent new
							selectionModel: self selectionModel;
			            command: aCommand;
			            yourself) ]
		on: ToIncompatibleMode
		do: [ :err | self onSelectionRequestError: err. ^ self].
	request selectionChanged ifFalse: [ ^ self ].
	self dispatchSelectionChanged.
	self onSelectionRequestSuccess: request
]

{ #category : #'event dispatching' }
ToSelectionModelOperator >> dispatchSelectionChanged [

	self eventTarget dispatchEvent: (ToListSelectionChangedEvent new
			 selectionModel: self selectionModel;
			 yourself)
]

{ #category : #accessing }
ToSelectionModelOperator >> eventTarget [ 

	^ eventTarget
]

{ #category : #initialization }
ToSelectionModelOperator >> on: anEventTarget [

	eventTarget := anEventTarget
]

{ #category : #'event dispatching' }
ToSelectionModelOperator >> onSelectionRequestError: anError [

	anError signal
]

{ #category : #'event dispatching' }
ToSelectionModelOperator >> onSelectionRequestSuccess: aSelectionRequestEvent [

	self dispatchCommandResult: aSelectionRequestEvent command
]

{ #category : #operations }
ToSelectionModelOperator >> selectAll [

	self dispatchEventForCommand: (ToWholeSelectionCommand new
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelOperator >> selectAllIndexes: anArray [

	self dispatchEventForCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> selectIndex: anIndex [

	self dispatchEventForCommand: (ToIntervalSelectionCommand new
			 interval: (anIndex to: anIndex);
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> selectIndex: aStartIndex to: anEndIndex [

	self dispatchEventForCommand: (ToIntervalSelectionCommand new
			 interval: (aStartIndex to: anEndIndex);
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToSelectionModelOperator >> selectOnlyIndex: anIndex [

	self dispatchEventForCommand:
		((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIntervalSelectionCommand new
				  interval: (anIndex to: anIndex);
				  operation: ToAddSelectionOperation new))
]

{ #category : #operations }
ToSelectionModelOperator >> selectOnlyIndexes: anArray [

	self dispatchEventForCommand:
		((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIndexesSelectionCommand new
				  indexes: anArray;
				  operation: ToAddSelectionOperation new))
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionModel [

	^ self eventTarget selectionModel
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionStrategy [

	^ self eventTarget selectionStrategy
]
