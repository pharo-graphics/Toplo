Class {
	#name : #ToListSubSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'parentMode'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToListSubSelectionMode class >> parentMode: aParentMode [

	^ self basicNew
		  parentMode: aParentMode;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
ToListSubSelectionMode >> newSelecter [

	^ ToSubSelecter new
		  parentSelecter: parentMode selecter;
		  yourself
]

{ #category : #'instance creation' }
ToListSubSelectionMode >> newSelectionModel [

	^ ToSubSelectionModel new
]

{ #category : #accessing }
ToListSubSelectionMode >> parentMode: aSelectionMode [

	parentMode := aSelectionMode
]
