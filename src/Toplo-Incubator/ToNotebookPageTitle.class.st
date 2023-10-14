Class {
	#name : 'ToNotebookPageTitle',
	#superclass : 'ToGeneralButton',
	#instVars : [
		'page',
		'labelElement'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'skin' }
ToNotebookPageTitle >> defaultBorder [

	^ BlBorder empty
]

{ #category : 'skin' }
ToNotebookPageTitle >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 4;
			   topRight: 4;
			   bottomLeft: 0;
			   bottomRight: 0;
			   yourself)
]

{ #category : 'initialization' }
ToNotebookPageTitle >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : 'skin' }
ToNotebookPageTitle >> defaultPadding [

	^ BlInsets vertical: 2
]

{ #category : 'dressing' }
ToNotebookPageTitle >> dressCloseable [

	| closeButton |
	closeButton := self childWithId: #closeButton
]

{ #category : 'dressing' }
ToNotebookPageTitle >> dressDeselected [

	self background: self theme notebook deselectedPageTitleBackgroundColor
]

{ #category : 'dressing' }
ToNotebookPageTitle >> dressSelected [

	self background:
		self theme notebook selectedPageTitleBackgroundColor
]

{ #category : 'initialization' }
ToNotebookPageTitle >> initialize [

	super initialize.

	labelElement := ToLabel new.
	self addChild: labelElement.
	
]

{ #category : 'skin' }
ToNotebookPageTitle >> installRawStyle [

	super installRawStyle.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c linear vertical alignBottom ].
	labelElement margin: (BlInsets horizontal: 20).
	labelElement constraintsDo: [ :c | c linear vertical alignCenter].

]

{ #category : 'accessing' }
ToNotebookPageTitle >> labelElement [

	^ labelElement
]

{ #category : 'accessing' }
ToNotebookPageTitle >> page [

	^ page
]

{ #category : 'accessing' }
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

{ #category : 'api - install/uninstall  hook' }
ToNotebookPageTitle >> refreshIsCloseable [

	self page isCloseable ifFalse: [ ^ self ].
	self dressCloseable
]

{ #category : 'api - install/uninstall  hook' }
ToNotebookPageTitle >> refreshIsSelected [

	self page isSelected
		ifTrue: [ self dressSelected ]
		ifFalse: [ self dressDeselected ]
]

{ #category : 'accessing' }
ToNotebookPageTitle >> title: aString [ 
	
	labelElement text: aString asRopedText
]
