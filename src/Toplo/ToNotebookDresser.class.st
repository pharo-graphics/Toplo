Class {
	#name : #ToNotebookDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Notebook'
}

{ #category : #'api - install/uninstall  hook' }
ToNotebookDresser >> onInstalledIn: aToNotebook [

	super onInstalledIn: aToNotebook.

	aToNotebook header
		layout: BlLinearLayout horizontal;
		background: theme notebook headerBackgroundColor.
	aToNotebook layout: BlLinearLayout vertical.
	
	aToNotebook constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	aToNotebook header constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 30 ]

]

{ #category : #accessing }
ToNotebookDresser >> pageTitleDresser [

	^ ToNotebookPageTitleDresser new
		notebookDresser: self;
		yourself
]
