"
A ToSelectionCommandTest is a test class for testing the behavior of ToSelectionCommand
"
Class {
	#name : #ToSelectionCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'addedIndexes',
		'removedIndexes',
		'addedInterval',
		'removedInterval',
		'wholeSelection',
		'noSelection'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #tests }
ToSelectionCommandTest >> addIndexesSelectionCommand: aCommand [

	addedIndexes := aCommand indexes
]

{ #category : #tests }
ToSelectionCommandTest >> addIntervalSelectionCommand: aCommand [

	addedInterval := aCommand interval
]

{ #category : #accessing }
ToSelectionCommandTest >> addedIndexes [

	^ addedIndexes
]

{ #category : #accessing }
ToSelectionCommandTest >> addedInterval [

	^ addedInterval
]

{ #category : #tests }
ToSelectionCommandTest >> removeIndexesSelectionCommand: aCommand [

	removedIndexes := aCommand indexes
]

{ #category : #tests }
ToSelectionCommandTest >> removeIntervalSelectionCommand: aCommand [

	removedInterval := aCommand interval
]

{ #category : #accessing }
ToSelectionCommandTest >> removedIndexes [

	^ removedIndexes
]

{ #category : #accessing }
ToSelectionCommandTest >> removedInterval [

	^ removedInterval
]

{ #category : #running }
ToSelectionCommandTest >> setUp [ 

	super setUp.
	addedIndexes := nil.
	removedIndexes := nil.
	addedInterval := nil.
	removedInterval := nil.
	wholeSelection := nil.
	noSelection := nil
]

{ #category : #tests }
ToSelectionCommandTest >> testIndexesAddSelectionCommand [

	| cmd |
	cmd := ToIndexesSelectionCommand new.
	cmd indexes: #(1).
	cmd operation: ToAddSelectionOperation new.
	cmd applyOn: self.
	self assert: self addedIndexes equals: #(1)
]

{ #category : #tests }
ToSelectionCommandTest >> testIndexesRemoveSelectionCommand [

	| cmd |
	cmd := ToIndexesSelectionCommand new.
	cmd indexes: #(1).
	cmd operation: ToRemoveSelectionOperation new.
	cmd applyOn: self.
	self assert: self removedIndexes equals: #(1)
]

{ #category : #tests }
ToSelectionCommandTest >> testIntervalAddSelectionCommand [

	| cmd |
	cmd := ToIntervalSelectionCommand new.
	cmd interval: ( 1 to: 2).
	cmd operation: ToAddSelectionOperation new.
	cmd applyOn: self.
	self assert: self addedInterval equals: ( 1 to: 2)
]

{ #category : #tests }
ToSelectionCommandTest >> testIntervalRemoveSelectionCommand [

	| cmd |
	cmd := ToIntervalSelectionCommand new.
	cmd interval: ( 1 to: 2).
	cmd operation: ToRemoveSelectionOperation new.
	cmd applyOn: self.
	self assert: self removedInterval equals: ( 1 to: 2)
]
