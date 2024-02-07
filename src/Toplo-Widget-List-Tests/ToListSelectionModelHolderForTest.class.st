Class {
	#name : #ToListSelectionModelHolderForTest,
	#superclass : #ToSelectionModelHolderForTest,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionCommandChecker'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #accessing }
ToListSelectionModelHolderForTest >> checker: aSelectionCommandChecker [

	selectionCommandChecker := aSelectionCommandChecker
]

{ #category : #initialization }
ToListSelectionModelHolderForTest >> initialize [ 

	super initialize.
	self checker: ToListMultiSelectionCommandChecker new.

]

{ #category : #accessing }
ToListSelectionModelHolderForTest >> selecter [

	^ super selecter
		  checker: self selectionCommandChecker;
		  yourself
]

{ #category : #accessing }
ToListSelectionModelHolderForTest >> selectionCommandChecker [

	^ selectionCommandChecker
]
