Class {
	#name : #ToSelectionRequestEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - accessing' }
ToSelectionRequestEventHandler >> eventsToHandle [

	^ { ToSelectionRequestEvent }
]

{ #category : #'event handling' }
ToSelectionRequestEventHandler >> selectionRequestEvent: aSelectionRequestEvent [

	| previousModel targetModel |
	targetModel := aSelectionRequestEvent currentTarget selectionModel.
	previousModel := targetModel copy.
	targetModel applyCommand: aSelectionRequestEvent command.
	aSelectionRequestEvent selectionChanged: previousModel ~= targetModel
]
