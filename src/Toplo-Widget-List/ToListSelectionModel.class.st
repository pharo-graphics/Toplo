Class {
	#name : #ToListSelectionModel,
	#superclass : #ToSelectionModel,
	#instVars : [
		'currentIndex',
		'distance',
		'pivot'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'private - command handling' }
ToListSelectionModel >> addIndexesSelectionCommand: aCommand [

	super addIndexesSelectionCommand: aCommand.
	self markPointedPosition: aCommand indexes first
]

{ #category : #'private - command handling' }
ToListSelectionModel >> addIntervalSelectionCommand: aCommand [

	super addIntervalSelectionCommand: aCommand.
	self markPointedPosition: aCommand interval last
]

{ #category : #'private - command handling' }
ToListSelectionModel >> addWholeSelectionCommand: aCommand [

	super addWholeSelectionCommand: aCommand.
	self markPointedPosition: 0
]

{ #category : #accessing }
ToListSelectionModel >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToListSelectionModel >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #accessing }
ToListSelectionModel >> distance [

	^ distance
]

{ #category : #accessing }
ToListSelectionModel >> distance: anInteger [

	distance := anInteger
]

{ #category : #'private - operations' }
ToListSelectionModel >> markPointedPosition: anInteger [

	" pivot and distance are used for shift-arrow-up and down management "
	self pivot: nil.
	self distance: nil.
	self currentIndex: anInteger.

]

{ #category : #'instance creation' }
ToListSelectionModel >> newSelecter [

	^ ToListSelectionModelOperator new 
]

{ #category : #accessing }
ToListSelectionModel >> pivot [

	^ pivot
]

{ #category : #accessing }
ToListSelectionModel >> pivot: anInteger [

	pivot := anInteger
]

{ #category : #'private - command handling' }
ToListSelectionModel >> removeIndexesSelectionCommand: aCommand [

	super removeIndexesSelectionCommand: aCommand.
	self markPointedPosition: aCommand indexes first
]

{ #category : #'private - command handling' }
ToListSelectionModel >> removeIntervalSelectionCommand: aCommand [

	super removeIntervalSelectionCommand: aCommand.
	self markPointedPosition: aCommand interval first
]

{ #category : #'command handling' }
ToListSelectionModel >> removeWholeSelectionCommand: aCommand [

	super removeWholeSelectionCommand: aCommand.
	self markPointedPosition: 0
]
