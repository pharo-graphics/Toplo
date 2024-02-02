Class {
	#name : #ToListSelectionStrategy,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'mode',
		'selectionModel',
		'dataSource'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #'command handling' }
ToListSelectionStrategy >> addIndexesSelectionCommand: aCommand [

	self selectionModel selectAllIndexes: aCommand indexes
]

{ #category : #'command handling' }
ToListSelectionStrategy >> addIntervalSelectionCommand: aCommand [

	self selectionModel
		select: aCommand interval first - 1
		to: aCommand interval last
]

{ #category : #'command handling' }
ToListSelectionStrategy >> addWholeSelectionCommand: aCommand [

	self selectionModel
		select: 0
		to: self dataSource size
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

	^ { ToSelectionCommandEvent }
]

{ #category : #accessing }
ToListSelectionStrategy >> mode [

	^ mode ifNil: [ mode := ToListMultiSelectionMode new ]
]

{ #category : #accessing }
ToListSelectionStrategy >> mode: aListSelectionMode [

	mode := aListSelectionMode
]

{ #category : #'command handling' }
ToListSelectionStrategy >> removeIndexesSelectionCommand: aCommand [

	self selectionModel deselectAllIndexes: aCommand indexes
]

{ #category : #'command handling' }
ToListSelectionStrategy >> removeIntervalSelectionCommand: aCommand [

	self selectionModel
		deselect: aCommand interval first - 1
		to: aCommand interval last
]

{ #category : #'command handling' }
ToListSelectionStrategy >> removeWholeSelectionCommand: aCommand [

	self selectionModel
		deselect: 0
		to: self dataSource size
]

{ #category : #'event handling' }
ToListSelectionStrategy >> selectionCommandEvent: aSelectionEvent [

	self selectionModel: aSelectionEvent currentTarget selectionModel.
	self dataSource: aSelectionEvent currentTarget dataSource.
	aSelectionEvent command
		applyOn: self mode;
		applyOn: self.
	self selectionModel: nil.
	self dataSource: nil
]

{ #category : #accessing }
ToListSelectionStrategy >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelectionStrategy >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
