Class {
	#name : #ToSelectionModelOperator,
	#superclass : #ToCommandApplier,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel selectAllIndexes: aCommand indexes
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addIntervalSelectionCommand: aCommand [

	self selectionModel selectIndex: aCommand from to: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addWholeSelectionCommand: aCommand [

	self selectionModel selectAll
]

{ #category : #'command application' }
ToSelectionModelOperator >> applyCommand: aCommand for: aTarget [

	| previousModel dispatch |
	aCommand silent ifFalse: [ previousModel := self selectionModel copy ].

	super applyCommand: aCommand for: aTarget.

	dispatch := aCommand silent
		            ifTrue: [ false ]
		            ifFalse: [ previousModel ~= self selectionModel ].

	aTarget dispatchEvent: (ToSelectionCommandAppliedEvent new
			 operator: self;
			 command: aCommand).

	dispatch ifFalse: [ ^ self ].
	aTarget dispatchEvent: (ToListSelectionChangedEvent new
			 selectionModel: self selectionModel copy;
			 yourself)
]

{ #category : #accessing }
ToSelectionModelOperator >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #'api - hooks' }
ToSelectionModelOperator >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	self selectionModel: anEventTarget selectionModel
]

{ #category : #'api - hooks' }
ToSelectionModelOperator >> onUninstalledIn: anEventTarget [

	super onUninstalledIn: anEventTarget.
	self selectionModel: nil
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel deselectAllIndexes: aCommand indexes
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIntervalSelectionCommand: aCommand [

	self selectionModel deselectIndex: aCommand from to: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeWholeSelectionCommand: aCommand [

	self selectionModel deselectAll
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #'as yet unclassified' }
ToSelectionModelOperator >> selectionModelShiftCommand: aShiftCommand [

	self selectionModel shift: aShiftCommand itemCount from: aShiftCommand fromIndex
]

{ #category : #accessing }
ToSelectionModelOperator >> sharedEvents [

	^ super sharedEvents , {
		  ToSelectionCommandAppliedEvent.
		  ToListSelectionChangedEvent }
]
