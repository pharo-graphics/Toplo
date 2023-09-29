Class {
	#name : #ToNotebookPageTitleDresser,
	#superclass : #ToWidgetDresser,
	#instVars : [
		'notebookDresser'
	],
	#category : #'Toplo-Incubator'
}

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
