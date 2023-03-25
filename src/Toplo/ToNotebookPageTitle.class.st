Class {
	#name : #ToNotebookPageTitle,
	#superclass : #ToGeneralButton,
	#instVars : [
		'page',
		'labelElement'
	],
	#category : #'Toplo-Widget-Notebook'
}

{ #category : #initialization }
ToNotebookPageTitle >> initialize [

	super initialize.
	
	labelElement := ToLabel new.
	labelElement matchParent.
	self addChild: labelElement.
]

{ #category : #accessing }
ToNotebookPageTitle >> labelElement [

	^ labelElement
]

{ #category : #accessing }
ToNotebookPageTitle >> page [

	^ page
]

{ #category : #accessing }
ToNotebookPageTitle >> page: aPage [

	page := aPage
]

{ #category : #accessing }
ToNotebookPageTitle >> title: aString [ 
	
	labelElement text: aString asRopedText
]
