Class {
	#name : #ToListSelectionStrategy,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'mode',
		'selectionModel',
		'dataSource',
		'selectionChanged'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #'command handling' }
ToListSelectionStrategy >> addIndexesSelectionCommand: aCommand [

	aCommand indexes do: [ :idx |
			self selectionModel selectIndex: idx ]
]

{ #category : #'command handling' }
ToListSelectionStrategy >> addIntervalSelectionCommand: aCommand [

	self selectionModel
		select: aCommand interval first - 1
		to: aCommand interval last
]

{ #category : #'command handling' }
ToListSelectionStrategy >> addWholeSelectionCommand: aCommand [

	self selectionModel select: 0 to: self dataSource size
]

{ #category : #accessing }
ToListSelectionStrategy >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToListSelectionStrategy >> dataSource: aDataSource [

	dataSource := aDataSource
]

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

{ #category : #'command handling' }
ToListSelectionStrategy >> removeIndexesSelectionCommand: aCommand [

	aCommand indexes do: [ :idx | self selectionModel deselectIndex: idx ]
]

{ #category : #'command handling' }
ToListSelectionStrategy >> removeIntervalSelectionCommand: aCommand [

	self selectionModel
		deselect: aCommand interval first - 1
		to: aCommand interval last
]

{ #category : #'command handling' }
ToListSelectionStrategy >> removeWholeSelectionCommand: aCommand [

	self selectionModel isEmpty ifTrue: [ ^ self ].
	self selectionModel
		deselect: 0
		to: self dataSource size
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
	self selectionModel: aSelectionEvent currentTarget selectionModel.
	self dataSource: aSelectionEvent currentTarget dataSource.
	previousModel := self selectionModel copy.
	aSelectionEvent command
		applyOn: self mode;
		applyOn: self.
	selectionChanged := previousModel ~= self selectionModel.
	aSelectionEvent selectionChanged: selectionChanged.
	previousModel := nil.
	self selectionModel: nil.
	self dataSource: nil.

]
