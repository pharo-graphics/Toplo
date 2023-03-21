Class {
	#name : #ToNotebookPage,
	#superclass : #Object,
	#instVars : [
		'titleElement',
		'bodyElement'
	],
	#category : #'Toplo-Widget-Notebook'
}

{ #category : #accessing }
ToNotebookPage >> bodyElement [

	^ bodyElement
]

{ #category : #accessing }
ToNotebookPage >> bodyElement: aBlElement [

	bodyElement := aBlElement
]

{ #category : #accessing }
ToNotebookPage >> titleElement [

	^ titleElement
]

{ #category : #accessing }
ToNotebookPage >> titleElement: aBlElement [

	titleElement := aBlElement
]
