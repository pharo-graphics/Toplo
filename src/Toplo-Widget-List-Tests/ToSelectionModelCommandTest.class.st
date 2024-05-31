"
A ToSelectionCommandTest is a test class for testing the behavior of ToSelectionCommand
"
Class {
	#name : #ToSelectionModelCommandTest,
	#superclass : #TestCase,
	#traits : 'TToPrenotificationTarget',
	#classTraits : 'TToPrenotificationTarget classTrait',
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

{ #category : #'command application' }
ToSelectionModelCommandTest >> applyCommand: aCommand [

	aCommand applyOnOperator: self
]

{ #category : #'event management' }
ToSelectionModelCommandTest >> dispatchEvent: anEvent [

	(anEvent isKindOf: ToElementCommandApplicationEvent) ifTrue: [
		anEvent sendTo: self ]
]

{ #category : #'event management' }
ToSelectionModelCommandTest >> elementCommandApplicationEvent: anEvent [

	anEvent operator applyCommand: anEvent command
]

{ #category : #'t - infinite accessing' }
ToSelectionModelCommandTest >> layoutCritical: aBlock [

	aBlock value
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
	cmd := ToIndexesSelectionCommand new.
	cmd indexes: #(1).
	cmd operation: ToAddSelectionOperation new.
	cmd notifyAddedInOperator: self.
	self assert: self addIndexesCommand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testAddIntervalSelectionCommand [

	| cmd |
	cmd := ToIntervalSelectionCommand new.
	cmd from: 1 to: 2.
	cmd operation: ToAddSelectionOperation new.
	cmd notifyAddedInOperator: self.
	self assert: self addIntervalCommand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testAddWholeSelectionCommand [

	| cmd |
	cmd := ToWholeSelectionCommand new.
	cmd operation: ToAddSelectionOperation new.
	cmd notifyAddedInOperator: self.
	self assert: self wholeSelectionCommand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testRemoveIndexesSelectionCommand [

	| cmd |
	cmd := ToIndexesSelectionCommand new.
	cmd indexes: #(1).
	cmd operation: ToRemoveSelectionOperation new.
	cmd notifyAddedInOperator: self.
	self assert: self removeIndexesCommand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testRemoveIntervalSelectionCommand [

	| cmd |
	cmd := ToIntervalSelectionCommand new.
	cmd from: 1 to: 2.
	cmd operation: ToRemoveSelectionOperation new.
	cmd notifyAddedInOperator: self.
	self assert: self removeIntervalCommmand equals: cmd
]

{ #category : #tests }
ToSelectionModelCommandTest >> testRemoveWholeSelectionCommand [

	| cmd |
	cmd := ToWholeSelectionCommand new.
	cmd operation: ToRemoveSelectionOperation new.
	cmd notifyAddedInOperator: self.
	self assert: self noSelectionCommand equals: cmd
]

{ #category : #accessing }
ToSelectionModelCommandTest >> wholeSelectionCommand [

	^ wholeSelectionCommand
]
