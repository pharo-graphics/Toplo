"
I'm part of a larger example. I'm not expected to be used as a standalone.
"
Class {
	#name : #ToListSelectionTraceExampleEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'currentTarget',
		'traceSelectionModel'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'event handling' }
ToListSelectionTraceExampleEventHandler >> addIndexesSelectionCommand: aCommand [

	
	aCommand operation deselectAllBefore ifTrue: [
		traceSelectionModel deselectAll ].
	traceSelectionModel selectIndexes: aCommand indexes.
	traceSelectionModel deselectIndex: aCommand indexes last
]

{ #category : #'event handling' }
ToListSelectionTraceExampleEventHandler >> addIntervalSelectionCommand: aCommand [
	aCommand operation deselectAllBefore ifTrue: [
		traceSelectionModel deselectAll ].
	traceSelectionModel selectIndexes: currentTarget selectionModel selectedIndexes.
	traceSelectionModel deselectIndex: aCommand to
]

{ #category : #'event handling' }
ToListSelectionTraceExampleEventHandler >> addWholeSelectionCommand: aCommand [

	traceSelectionModel
		selectIndex: 1
		to: currentTarget selectionModel itemCount - 1
]

{ #category : #'api - accessing' }
ToListSelectionTraceExampleEventHandler >> eventsToHandle [

	^ { ToListSelectionCommandAppliedEvent }
]

{ #category : #'event handling' }
ToListSelectionTraceExampleEventHandler >> listSelectionCommandAppliedEvent: aCommandAppliedEvent [

	currentTarget := aCommandAppliedEvent currentTarget.
	
	" check that the command is applied on the primary selection model "
	aCommandAppliedEvent selectionModel == currentTarget selectionModel
		ifFalse: [ ^ self ].

	traceSelectionModel := currentTarget userData at: #traceSelectionModel.
	
	aCommandAppliedEvent command applyWithOperator: self.

	currentTarget := nil.
	traceSelectionModel := nil
]

{ #category : #'event handling' }
ToListSelectionTraceExampleEventHandler >> removeIndexesSelectionCommand: aCommand [

	traceSelectionModel deselectIndex: aCommand indexes
]

{ #category : #'event handling' }
ToListSelectionTraceExampleEventHandler >> removeIntervalSelectionCommand: aCommand [
	
	traceSelectionModel deselectIndex: aCommand from to: aCommand to
]

{ #category : #'event handling' }
ToListSelectionTraceExampleEventHandler >> removeWholeSelectionCommand: aCommand [

	traceSelectionModel deselectAll 
]
