"
A ToSelectionUpdaterTest is a test class for testing the behavior of ToSelectionUpdater
"
Class {
	#name : #ToSelectionModelUpdaterTest,
	#superclass : #TestCase,
	#instVars : [
		'updater'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Updater'
}

{ #category : #tests }
ToSelectionModelUpdaterTest >> setUp [ 

	super setUp.
	updater := ToSelectionModelUpdater new 


]

{ #category : #tests }
ToSelectionModelUpdaterTest >> testDispatchEvent [

	| selectionModel request |
	selectionModel := ToSelectionModel new.
	updater selectionModel: selectionModel.
	request := ToSelectionRequestEvent new.
	request command: (ToWholeSelectionCommand new operation: ToAddSelectionOperation new).
	updater dispatchEvent: request.
	self assert: request selectionChanged.
	self assert: selectionModel isWholeSelectionModel.
]

{ #category : #tests }
ToSelectionModelUpdaterTest >> testInitialize [

	self assert: (updater eventDispatcher isKindOf: BlDirectEventDispatcher).
	self assert: (updater eventDispatcher handlers
			 detect: [ :handler |
			 handler isKindOf: ToSelectionRequestEventHandler ]
			 ifNone: [  ]) notNil.
	self assert: updater selectionModel isNil
]

{ #category : #tests }
ToSelectionModelUpdaterTest >> testSelectionModel [

	| selectionModel |
	selectionModel := ToSelectionModel new.
	updater selectionModel: selectionModel.
	self assert: selectionModel identicalTo: updater selectionModel
]
