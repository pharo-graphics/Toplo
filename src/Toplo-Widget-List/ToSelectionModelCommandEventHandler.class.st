Class {
	#name : #ToSelectionModelCommandEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - accessing' }
ToSelectionModelCommandEventHandler >> eventsToHandle [

	^ { ToSelectionModelCommandAddedEvent. ToSelectionRequestEvent }
]

{ #category : #'event handling' }
ToSelectionModelCommandEventHandler >> selectionModelCommandAddedEvent: aSelectionCommandAddedEvent [

	
]

{ #category : #'event handling' }
ToSelectionModelCommandEventHandler >> selectionRequestEvent: aSelectionRequestEvent [

	| previousModel targetModel |
	targetModel := aSelectionRequestEvent currentTarget selectionModel.
	previousModel := targetModel copy.
	targetModel applyCommand: aSelectionRequestEvent command.
	aSelectionRequestEvent selectionChanged: previousModel ~= targetModel
]
