Class {
	#name : #ToNotebookDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Notebook'
}

{ #category : #accessing }
ToNotebookDresser >> newPageTitleDresser [

	^ ToNotebookPageTitleDresser new
		notebookDresser: self;
		yourself
]

{ #category : #'api - install/uninstall  hook' }
ToNotebookDresser >> onInstalledIn: aToNotebook [

	super onInstalledIn: aToNotebook.

	aToNotebook background: theme notebook backgroundColor.
	
	aToNotebook header layout: BlLinearLayout horizontal.
	aToNotebook layout: BlLinearLayout vertical.
	
	aToNotebook constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	aToNotebook header constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 30 ]

]
