Class {
	#name : #ToNotebookDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Incubator'
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

	aToNotebook
		background: theme notebook backgroundColor;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	aToNotebook header
		layout: 
			(BlLinearLayout horizontal
				cellSpacing: 4;
				yourself);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 30 ]
]
