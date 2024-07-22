Class {
	#name : #ToListSubSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'parentMode',
		'selectionChangedEventClass'
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
		  selectionChangedEventClass: self selectionChangedEventClass;
		  parentSelecter: parentMode selecter;
		  yourself
]

{ #category : #'instance creation' }
ToListSubSelectionMode >> newSelectionModelIn: aListElement [

	^ ToSubSelectionModel new
]

{ #category : #accessing }
ToListSubSelectionMode >> parentMode: aSelectionMode [

	parentMode := aSelectionMode
]

{ #category : #accessing }
ToListSubSelectionMode >> selectionChangedEventClass: anEventClass [

	selectionChangedEventClass := anEventClass
]
