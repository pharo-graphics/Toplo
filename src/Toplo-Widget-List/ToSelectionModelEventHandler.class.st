Class {
	#name : #ToSelectionModelEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionUpdateTask'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - accessing' }
ToSelectionModelEventHandler >> eventsToHandle [

	^ { ToSelectionCommandAddedEvent. ToSelectionRequestEvent }
]

{ #category : #'event handling' }
ToSelectionModelEventHandler >> selectionCommandAddedEvent: aSelectionCommandAddedEvent [

	| target |
	target := aSelectionCommandAddedEvent target.
	target isAttachedToSceneGraph ifFalse: [
		target selecter apply.
		^ self ].
	selectionUpdateTask ifNotNil: [ ^ self ].
	selectionUpdateTask := BlTaskAction new action: [
		                       target selecter apply.
		                       selectionUpdateTask := nil ].
	target enqueueTask: selectionUpdateTask.
	target requestLayout
]

{ #category : #'event handling' }
ToSelectionModelEventHandler >> selectionRequestEvent: aSelectionRequestEvent [

	| previousModel targetModel |
	targetModel := aSelectionRequestEvent currentTarget selectionModel.
	previousModel := targetModel copy.
	targetModel applyCommand: aSelectionRequestEvent command.
	aSelectionRequestEvent selectionChanged: previousModel ~= targetModel
]
