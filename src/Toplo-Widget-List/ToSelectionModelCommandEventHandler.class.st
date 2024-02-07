Class {
	#name : #ToSelectionModelCommandEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionUpdateTask'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - accessing' }
ToSelectionModelCommandEventHandler >> eventsToHandle [

	^ { ToSelectionModelCommandAddedEvent. ToSelectionRequestEvent }
]

{ #category : #'event handling' }
ToSelectionModelCommandEventHandler >> selectionModelCommandAddedEvent: aSelectionCommandAddedEvent [

	| target |
	target := aSelectionCommandAddedEvent target.
	target isAttachedToSceneGraph ifFalse: [
		target selecter apply.
		^ self ].
	selectionUpdateTask ifNotNil: [ ^ self ].
	selectionUpdateTask := BlTaskAction new action: [
		                       target selecter apply.
		                       selectionUpdateTask := nil ].
	target enqueueTask: selectionUpdateTask
]

{ #category : #'event handling' }
ToSelectionModelCommandEventHandler >> selectionRequestEvent: aSelectionRequestEvent [

	| previousModel targetModel |
	targetModel := aSelectionRequestEvent currentTarget selectionModel.
	previousModel := targetModel copy.
	targetModel applyCommand: aSelectionRequestEvent command.
	aSelectionRequestEvent selectionChanged: previousModel ~= targetModel
]
