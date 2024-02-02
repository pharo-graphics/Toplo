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

	self dispatchEvent: (ToSelectionCommandEvent new command:
			 (ToWholeSelectionCommand new operation:
				  ToRemoveSelectionOperation new))
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> deselectAllIndexes: anArray [

	self dispatchEvent: (ToSelectionCommandEvent new
			 command: (ToIndexesSelectionCommand new
					  indexes: anArray;
					  operation: ToRemoveSelectionOperation new))
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> deselectIndex: anIndex [

	self dispatchEvent: (ToSelectionCommandEvent new
			 command: (ToIntervalSelectionCommand new
					  interval: (anIndex to: anIndex);
					  operation: ToRemoveSelectionOperation new))
]

{ #category : #'t - list selection operator - accessing' }
TToListSelectionOperator >> eventTarget [

	^ self explicitRequirement 
]

{ #category : #'t - list selection operator - hook' }
TToListSelectionOperator >> installStrategy: aSelectionStrategy [

	self eventTarget addEventHandler: aSelectionStrategy
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> selectAll [

	self dispatchEvent: (ToSelectionCommandEvent new command:
			 (ToWholeSelectionCommand new operation:
				  ToAddSelectionOperation new))
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> selectAllIndexes: anArray [

	self dispatchEvent: (ToSelectionCommandEvent new
			 command: (ToIndexesSelectionCommand new
					  indexes: anArray;
					  operation: ToAddSelectionOperation new))
]

{ #category : #'t - list selection operator - commands' }
TToListSelectionOperator >> selectIndex: anIndex [

	self dispatchEvent: (ToSelectionCommandEvent new
			 command: (ToIntervalSelectionCommand new
					  interval: (anIndex to: anIndex);
					  operation: ToAddSelectionOperation new))
]

{ #category : #'t - list selection operator - accessing' }
TToListSelectionOperator >> selectionModel [

	^ self explicitRequirement 
]

{ #category : #'t - list selection operator - hook' }
TToListSelectionOperator >> uninstallStrategy: aSelectionStrategy [

	self eventTarget removeEventHandler: aSelectionStrategy
]
