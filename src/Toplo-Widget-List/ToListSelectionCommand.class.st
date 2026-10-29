Class {
	#name : #ToListSelectionCommand,
	#superclass : #ToListDataSourceCommand,
	#instVars : [
		'applier',
		'selectionCommand'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #accessing }
ToListSelectionCommand >> applier: aCommandApplier [

	applier := aCommandApplier
]

{ #category : #application }
ToListSelectionCommand >> applyIn: aListElement [
	"Positions were computed before data source changes applied meanwhile"

	(selectionCommand selectsBeyond: applier itemCount) ifTrue: [ ^ self ].
	applier applyCommand: selectionCommand
]

{ #category : #accessing }
ToListSelectionCommand >> command: aSelectionCommand [

	selectionCommand := aSelectionCommand 
]

{ #category : #commands }
ToListSelectionCommand >> offsetPositionsIn: aListElement [

	self applyIn: aListElement
]
