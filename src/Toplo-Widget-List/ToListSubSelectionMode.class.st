Class {
	#name : #ToListSubSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'parentMode',
		'selectionChangedEventClass',
		'selectionChangeEventHandler'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSubSelectionMode class >> parentMode: aSelectionMode [

	^ self basicNew
		  parentMode: aSelectionMode;
		  initialize
]

{ #category : #'instance creation' }
ToListSubSelectionMode >> newSelecter [

	^ ToSubSelecter new
		  selectionModel: ToSubSelectionModel new;
		  selectionChangedEventClass: selectionChangedEventClass;
		  parentSelecter: parentMode selecter;
		  yourself
]

{ #category : #initialization }
ToListSubSelectionMode >> on: aListElement [

	super on: aListElement.
	selectionChangeEventHandler ifNil: [ ^ self ].
	aListElement addEventHandler: selectionChangeEventHandler 
]

{ #category : #accessing }
ToListSubSelectionMode >> parentMode: aSelectionMode [

	parentMode := aSelectionMode
]

{ #category : #accessing }
ToListSubSelectionMode >> selectionChangeEventHandler: anEventHandler [

	selectionChangeEventHandler := anEventHandler
]

{ #category : #'instance creation' }
ToListSubSelectionMode >> selectionChangedEventClass [

	^ selectionChangedEventClass
]

{ #category : #accessing }
ToListSubSelectionMode >> selectionChangedEventClass: anEventClass [

	selectionChangedEventClass := anEventClass
]
