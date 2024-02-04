Class {
	#name : #ToSelectionRequestEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionModel',
		'selectionChanged'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'api - accessing' }
ToSelectionRequestEventHandler >> eventsToHandle [

	^ { ToSelectionRequestEvent }
]

{ #category : #'api - hooks' }
ToSelectionRequestEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	selectionChanged := false
]

{ #category : #accessing }
ToSelectionRequestEventHandler >> selectionHasChanged [

	^ selectionChanged
]

{ #category : #accessing }
ToSelectionRequestEventHandler >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelectionRequestEventHandler >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #'event handling' }
ToSelectionRequestEventHandler >> selectionRequestEvent: aSelectionEvent [

	| previousModel |
	self selectionModel: aSelectionEvent currentTarget selectionModel.
	previousModel := self selectionModel copy.
	aSelectionEvent command
		applyOn: aSelectionEvent currentTarget selectionMode;
		applyOn: self selectionModel.
	aSelectionEvent selectionChanged: previousModel ~= self selectionModel.
	self selectionModel: nil
]
