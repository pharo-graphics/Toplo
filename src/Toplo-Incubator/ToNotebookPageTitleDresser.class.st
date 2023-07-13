Class {
	#name : #ToNotebookPageTitleDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'notebookDresser'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #'api - install/uninstall  hook' }
ToNotebookPageTitleDresser >> dressCloseable: aToNotebookTitle [

	| closeButton |
	closeButton := aToNotebookTitle childWithId: #closeButton.
	closeButton
		background: Color transparent;
		border: BlBorder empty;
		margin: (BlInsets top: 1 bottom: 2). "Check this"

]

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
	aToNotebookTitle
		border: BlBorder empty;
		padding: (BlInsets vertical: 2);
		geometry:
			(BlRoundedRectangleGeometry cornerRadii:
				(BlCornerRadii new
					topLeft: radius;
					topRight: radius;
					bottomLeft: 0;
					bottomRight: 0;
					yourself));
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c linear vertical alignBottom. ].

	aToNotebookTitle labelElement
		margin: (BlInsets horizontal: 20).

	"Force initial dress"
	self
		refreshIsSelected: aToNotebookTitle;
		refreshIsCloseable: aToNotebookTitle.

	"Refresh on change"
	aToNotebookTitle page
		whenIsSelectedChangedDo: [
			self refreshIsSelected: aToNotebookTitle ];
		whenIsCloseableChangedDo: [
			"Defer"
			aToNotebookTitle labelElement enqueueTask:
				(BlTaskAction new
					action: [ self refreshIsCloseable: aToNotebookTitle ];
				 	yourself) ]

]

{ #category : #'api - install/uninstall  hook' }
ToNotebookPageTitleDresser >> refreshIsCloseable: aToNotebookTitle [

	aToNotebookTitle page isCloseable ifFalse: [ ^ self ].
	self dressCloseable: aToNotebookTitle.
]

{ #category : #'api - install/uninstall  hook' }
ToNotebookPageTitleDresser >> refreshIsSelected: aToNotebookTitle [

	aToNotebookTitle page isSelected
		ifTrue: [ self dressSelected: aToNotebookTitle ]
		ifFalse: [ self dressDeselected: aToNotebookTitle ]
]
