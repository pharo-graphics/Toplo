"
A ToSelectionCommandTest is a test class for testing the behavior of ToSelectionCommand
"
Class {
	#name : #ToSelectionCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'addIndexesCommand',
		'removeIndexesCommand',
		'removeIntervalCommmand',
		'addIntervalCommand',
		'wholeSelectionCommand',
		'noSelectionCommand'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #accessing }
ToSelectionCommandTest >> addIndexesCommand [

	^ addIndexesCommand
]

{ #category : #tests }
ToSelectionCommandTest >> addIndexesSelectionCommand: aCommand [

	addIndexesCommand  := aCommand 
]

{ #category : #accessing }
ToSelectionCommandTest >> addIntervalCommand [

	^ addIntervalCommand
]

{ #category : #tests }
ToSelectionCommandTest >> addIntervalSelectionCommand: aCommand [

	addIntervalCommand := aCommand 
]

{ #category : #tests }
ToSelectionCommandTest >> addSelectionHolderCommand: aCommand [

	
]

{ #category : #tests }
ToSelectionCommandTest >> addWholeSelectionCommand: aCommand [

	wholeSelectionCommand := aCommand
]

{ #category : #accessing }
ToSelectionCommandTest >> noSelectionCommand [

	^ noSelectionCommand
]

{ #category : #accessing }
ToSelectionCommandTest >> removeIndexesCommand [

	^ removeIndexesCommand
]

{ #category : #tests }
ToSelectionCommandTest >> removeIndexesSelectionCommand: aCommand [

	removeIndexesCommand := aCommand
]

{ #category : #accessing }
ToSelectionCommandTest >> removeIntervalCommmand [

	^ removeIntervalCommmand
]

{ #category : #tests }
ToSelectionCommandTest >> removeIntervalSelectionCommand: aCommand [

	removeIntervalCommmand  := aCommand
]

{ #category : #tests }
ToSelectionCommandTest >> removeWholeSelectionCommand: aCommand [

	noSelectionCommand  := aCommand
]

{ #category : #running }
ToSelectionCommandTest >> setUp [

	super setUp.
	addIndexesCommand := nil.
	removeIndexesCommand := nil.
	removeIntervalCommmand := nil.
	addIntervalCommand := nil.
	wholeSelectionCommand := nil.
	noSelectionCommand := nil
]

{ #category : #tests }
ToSelectionCommandTest >> testAddIndexesSelectionCommand [

	| cmd |
	cmd := ToIndexesSelectionCommand new.
	cmd indexes: #(1).
	cmd operation: ToAddSelectionOperation new.
	cmd applyOn: self.
	self assert: self addIndexesCommand equals: cmd
]

{ #category : #tests }
ToSelectionCommandTest >> testAddIntervalSelectionCommand [

	| cmd |
	cmd := ToIntervalSelectionCommand new.
	cmd from: 1 to: 2.
	cmd operation: ToAddSelectionOperation new.
	cmd applyOn: self.
	self assert: self addIntervalCommand equals: cmd
]

{ #category : #tests }
ToSelectionCommandTest >> testAddWholeSelectionCommand [

	| cmd |
	cmd := ToWholeSelectionCommand new.
	cmd operation: ToAddSelectionOperation new.
	cmd applyOn: self.
	self assert: self wholeSelectionCommand equals: cmd
]

{ #category : #tests }
ToSelectionCommandTest >> testRemoveIndexesSelectionCommand [

	| cmd |
	cmd := ToIndexesSelectionCommand new.
	cmd indexes: #(1).
	cmd operation: ToRemoveSelectionOperation new.
	cmd applyOn: self.
	self assert: self removeIndexesCommand equals: cmd
]

{ #category : #tests }
ToSelectionCommandTest >> testRemoveIntervalSelectionCommand [

	| cmd |
	cmd := ToIntervalSelectionCommand new.
	cmd from: 1 to: 2.
	cmd operation: ToRemoveSelectionOperation new.
	cmd applyOn: self.
	self assert: self removeIntervalCommmand equals: cmd
]

{ #category : #tests }
ToSelectionCommandTest >> testRemoveWholeSelectionCommand [

	| cmd |
	cmd := ToWholeSelectionCommand new.
	cmd operation: ToRemoveSelectionOperation new.
	cmd applyOn: self.
	self assert: self noSelectionCommand equals: cmd
]

{ #category : #accessing }
ToSelectionCommandTest >> wholeSelectionCommand [

	^ wholeSelectionCommand
]
