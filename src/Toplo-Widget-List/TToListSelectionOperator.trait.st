Trait {
	#name : #TToListSelectionOperator,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #'t - list selection operator - accessing' }
TToListSelectionOperator >> dataSource [

	^ self explicitRequirement 
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> deselectAll [

	self dispatchEventForCommand:
		(ToWholeSelectionCommand new operation:
			 ToRemoveSelectionOperation new)
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> deselectAllIndexes: anArray [

	self dispatchEventForCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> deselectIndex: anIndex [

	self dispatchEventForCommand: (ToIntervalSelectionCommand new
			 interval: (anIndex to: anIndex);
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #'t - list selection operator - event dispatching' }
TToListSelectionOperator >> dispatchEventForCommand: aCommand [

	| request |
	[
	self eventTarget dispatchEvent:
		(request := ToSelectionRequestEvent new
			            command: aCommand;
			            yourself) ]
		on: ToIncompatibleMode
		do: [ :err | self onSelectionRequestError: err. ^ self].
	request selectionChanged ifFalse: [ ^ self ].
	self dispatchSelectionChanged.
	self onSelectionRequestSuccess: request
]

{ #category : #'t - list selection operator - event dispatching' }
TToListSelectionOperator >> dispatchSelectionChanged [

	self eventTarget dispatchEvent: (ToListSelectionChangedEvent new
			 selectionModel: self selectionModel;
			 yourself)
]

{ #category : #'t - list selection operator - accessing' }
TToListSelectionOperator >> eventTarget [

	^ self explicitRequirement 
]

{ #category : #'t - list selection operator - private' }
TToListSelectionOperator >> installStrategy: aSelectionStrategy [

	self eventTarget addEventHandler: aSelectionStrategy
]

{ #category : #'t - list selection operator - event dispatching' }
TToListSelectionOperator >> onSelectionRequestError: anError [

	anError signal
]

{ #category : #'t - list selection operator - event dispatching' }
TToListSelectionOperator >> onSelectionRequestSuccess: aSelectionRequestEvent [

	
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> selectAll [

	self dispatchEventForCommand:
		(ToWholeSelectionCommand new operation: ToAddSelectionOperation new)
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> selectAllIndexes: anArray [

	self dispatchEventForCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> selectIndex: anIndex [

	self dispatchEventForCommand: (ToIntervalSelectionCommand new
			 interval: (anIndex to: anIndex);
			 operation: ToAddSelectionOperation new)
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> selectIndex: aStartIndex to: anEndIndex [

	self dispatchEventForCommand: (ToIntervalSelectionCommand new
			 interval: (aStartIndex to: anEndIndex);
			 operation: ToAddSelectionOperation new)
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> selectOnlyIndex: anIndex [

	self dispatchEventForCommand:
		((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIntervalSelectionCommand new
				  interval: (anIndex to: anIndex);
				  operation: ToAddSelectionOperation new))
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> selectOnlyIndexes: anArray [

	self dispatchEventForCommand:
		((ToWholeSelectionCommand new operation:
			  ToRemoveSelectionOperation new) next:
			 (ToIndexesSelectionCommand new
				  indexes: anArray;
				  operation: ToAddSelectionOperation new))
]

{ #category : #'t - list selection operator - accessing' }
TToListSelectionOperator >> selectionModel [

	^ self explicitRequirement 
]

{ #category : #'t - list selection operator - private' }
TToListSelectionOperator >> uninstallStrategy: aSelectionStrategy [

	self eventTarget removeEventHandler: aSelectionStrategy
]
