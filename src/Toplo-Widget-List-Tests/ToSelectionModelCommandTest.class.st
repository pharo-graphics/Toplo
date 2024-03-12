"
A ToSelectionCommandTest is a test class for testing the behavior of ToSelectionCommand
"
Class {
	#name : #ToSelectionModelCommandTest,
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
ToSelectionModelCommandTest >> addIndexesCommand [

	^ addIndexesCommand
]

{ #category : #tests }
ToSelectionModelCommandTest >> addIndexesSelectionCommand: aCommand [

	addIndexesCommand  := aCommand 
]

{ #category : #accessing }
ToSelectionModelCommandTest >> addIntervalCommand [

	^ addIntervalCommand
]

{ #category : #tests }
ToSelectionModelCommandTest >> addIntervalSelectionCommand: aCommand [

	addIntervalCommand := aCommand 
]

{ #category : #tests }
ToSelectionModelCommandTest >> addWholeSelectionCommand: aCommand [

	wholeSelectionCommand := aCommand
]

{ #category : #running }
ToSelectionModelCommandTest >> applyCommand: aCommand in: aTarget [ 

	aCommand applyOn: self in: aTarget
]

{ #category : #accessing }
ToSelectionModelCommandTest >> noSelectionCommand [

	^ noSelectionCommand
]

{ #category : #accessing }
ToSelectionModelCommandTest >> removeIndexesCommand [

	^ removeIndexesCommand
]

{ #category : #tests }
ToSelectionModelCommandTest >> removeIndexesSelectionCommand: aCommand [

	removeIndexesCommand := aCommand
]

{ #category : #accessing }
ToSelectionModelCommandTest >> removeIntervalCommmand [

	^ removeIntervalCommmand
]

{ #category : #tests }
ToSelectionModelCommandTest >> removeIntervalSelectionCommand: aCommand [

	removeIntervalCommmand  := aCommand
]

{ #category : #tests }
ToSelectionModelCommandTest >> removeWholeSelectionCommand: aCommand [

	noSelectionCommand  := aCommand
]

{ #category : #running }
ToSelectionModelCommandTest >> setUp [

	super setUp.
	addIndexesCommand := nil.
	removeIndexesCommand := nil.
	removeIntervalCommmand := nil.
	addIntervalCommand := nil.
	wholeSelectionCommand := nil.
	noSelectionCommand := nil
]

{ #category : #tests }
ToSelectionModelCommandTest >> testAddIndexesSelectionCommand [

	| cmd |
	cmd := ToIndexesSelectionCommand new operator: self.
	cmd indexes: #(1).
	cmd operation: ToAddSelectionOperation new.
	cmd applyIn: nil.
	self assert: self addIndexesCommand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testAddIntervalSelectionCommand [

	| cmd |
	cmd := ToIntervalSelectionCommand new operator: self.
	cmd from: 1 to: 2.
	cmd operation: ToAddSelectionOperation new.
	cmd applyIn: nil.
	self assert: self addIntervalCommand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testAddWholeSelectionCommand [

	| cmd |
	cmd := ToWholeSelectionCommand new operator: self.
	cmd operation: ToAddSelectionOperation new.
	cmd applyIn: nil.
	self assert: self wholeSelectionCommand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testRemoveIndexesSelectionCommand [

	| cmd |
	cmd := ToIndexesSelectionCommand new operator: self.
	cmd indexes: #(1).
	cmd operation: ToRemoveSelectionOperation new.
	cmd applyIn: nil.
	self assert: self removeIndexesCommand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testRemoveIntervalSelectionCommand [

	| cmd |
	cmd := ToIntervalSelectionCommand new operator: self.
	cmd from: 1 to: 2.
	cmd operation: ToRemoveSelectionOperation new.
	cmd applyIn: nil.
	self assert: self removeIntervalCommmand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testRemoveWholeSelectionCommand [

	| cmd |
	cmd := ToWholeSelectionCommand new operator: self.
	cmd operation: ToRemoveSelectionOperation new.
	cmd applyIn: nil.
	self assert: self noSelectionCommand equals: cmd
]

{ #category : #accessing }
ToSelectionModelCommandTest >> wholeSelectionCommand [

	^ wholeSelectionCommand
]
