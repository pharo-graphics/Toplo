Class {
	#name : #ToNotebookPageTitleDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'notebookDresser'
	],
	#category : #'Toplo-Widget-Notebook'
}

{ #category : #'api - install/uninstall  hook' }
ToNotebookPageTitleDresser >> dressDeselected: aToNotebookTitle [

	aToNotebookTitle background:
		notebookDresser theme notebook deselectedPageTitleBackgroundColor
]

{ #category : #'api - install/uninstall  hook' }
ToNotebookPageTitleDresser >> dressSelected: aToNotebookTitle [

	aToNotebookTitle background:
		notebookDresser theme notebook selectedPageTitleBackgroundColor
]

{ #category : #accessing }
ToNotebookPageTitleDresser >> notebookDresser [

	^ notebookDresser
]

{ #category : #accessing }
ToNotebookPageTitleDresser >> notebookDresser: aToNotebookDresser [

	notebookDresser := aToNotebookDresser
]

{ #category : #'api - install/uninstall  hook' }
ToNotebookPageTitleDresser >> onInstalledIn: aToNotebookTitle [

	| radius |
	super onInstalledIn: aToNotebookTitle.

	radius := 4.
	aToNotebookTitle geometry:
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: radius;
				topRight: radius;
				bottomLeft: 0;
				bottomRight: 0;
				yourself)).
	aToNotebookTitle border: BlBorder empty.
	
	aToNotebookTitle labelElement
		margin: (BlInsets top: 2 right: 20 bottom: 2 left: 20).

	aToNotebookTitle constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c linear vertical alignBottom. ].

	self refreshIsSelected: aToNotebookTitle.
	aToNotebookTitle whenIsSelectedChangedDo: [ :newValue |
		self refreshIsSelected: aToNotebookTitle ]
]

{ #category : #'api - install/uninstall  hook' }
ToNotebookPageTitleDresser >> refreshIsSelected: aToNotebookTitle [

	aToNotebookTitle isSelected
		ifTrue: [ self dressSelected: aToNotebookTitle ]
		ifFalse: [ self dressDeselected: aToNotebookTitle ]
]
