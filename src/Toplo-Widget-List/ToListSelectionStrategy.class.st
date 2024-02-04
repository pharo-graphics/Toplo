Class {
	#name : #ToListSelectionStrategy,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'mode',
		'selectionModel',
		'selectionChanged'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'api - accessing' }
ToListSelectionStrategy >> eventsToHandle [

	^ { ToSelectionRequestEvent }
]

{ #category : #accessing }
ToListSelectionStrategy >> mode [

	^ mode ifNil: [ mode := ToListMultiSelectionMode new ]
]

{ #category : #accessing }
ToListSelectionStrategy >> mode: aListSelectionMode [

	mode := aListSelectionMode
]

{ #category : #'api - hooks' }
ToListSelectionStrategy >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	selectionChanged := false
]

{ #category : #accessing }
ToListSelectionStrategy >> selectionHasChanged [

	^ selectionChanged
]

{ #category : #accessing }
ToListSelectionStrategy >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelectionStrategy >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #'event handling' }
ToListSelectionStrategy >> selectionRequestEvent: aSelectionEvent [

	| previousModel |
	self selectionModel: aSelectionEvent selectionModel.
	previousModel := self selectionModel copy.
	aSelectionEvent command
		applyOn: self mode;
		applyOn: self selectionModel.
	selectionChanged := previousModel ~= self selectionModel.
	aSelectionEvent selectionChanged: selectionChanged.
	self selectionModel: nil
]
