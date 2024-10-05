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
		  selectionModel: ToSubSelectionModel new;
		  selectionChangedEventClass: self selectionChangedEventClass;
		  parentSelecter: parentMode selecter;
		  yourself
]

{ #category : #accessing }
ToListSubSelectionMode >> parentMode: aSelectionMode [

	parentMode := aSelectionMode
]

{ #category : #'instance creation' }
ToListSubSelectionMode >> selectionChangedEventClass [

	^ selectionChangedEventClass
]

{ #category : #accessing }
ToListSubSelectionMode >> selectionChangedEventClass: anEventClass [

	selectionChangedEventClass := anEventClass
]
