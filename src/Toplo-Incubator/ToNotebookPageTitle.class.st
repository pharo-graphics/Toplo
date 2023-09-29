Class {
	#name : #ToNotebookPageTitle,
	#superclass : #ToGeneralButton,
	#instVars : [
		'page',
		'labelElement'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #dressing }
ToNotebookPageTitle >> dressCloseable [

	| closeButton |
	closeButton := self childWithId: #closeButton.
	closeButton
		background: Color transparent;
		border: BlBorder empty;
		margin: (BlInsets top: 1 bottom: 2). "Check this"

]

{ #category : #dressing }
ToNotebookPageTitle >> dressDeselected [

	self background:
		self theme notebook deselectedPageTitleBackgroundColor
]

{ #category : #dressing }
ToNotebookPageTitle >> dressSelected [

	self background:
		self theme notebook selectedPageTitleBackgroundColor
]

{ #category : #initialization }
ToNotebookPageTitle >> initialize [

	| radius |
	super initialize.
	radius := 4.
	self
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

	labelElement := ToLabel new.
	labelElement margin: (BlInsets horizontal: 20).
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

	page := aPage.
	
	"Force initial dress"
	self
		refreshIsSelected;
		refreshIsCloseable.

	"Refresh on change"
	self page
		whenIsSelectedChangedDo: [
			self refreshIsSelected ];
		whenIsCloseableChangedDo: [
			"Defer"
			self labelElement enqueueTask:
				(BlTaskAction new
					action: [ self refreshIsCloseable ];
				 	yourself) ].
]

{ #category : #'api - install/uninstall  hook' }
ToNotebookPageTitle >> refreshIsCloseable [

	self page isCloseable ifFalse: [ ^ self ].
	self dressCloseable
]

{ #category : #'api - install/uninstall  hook' }
ToNotebookPageTitle >> refreshIsSelected [

	self page isSelected
		ifTrue: [ self dressSelected ]
		ifFalse: [ self dressDeselected ]
]

{ #category : #accessing }
ToNotebookPageTitle >> title: aString [ 
	
	labelElement text: aString asRopedText
]
