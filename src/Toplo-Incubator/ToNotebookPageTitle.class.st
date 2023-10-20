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
ToNotebookPageTitle >> defaultBackground [

	self page isSelected ifTrue: [
		^ Color fromHexString: #ffd666 ].
	^ super defaultBackground
]

{ #category : 'skin' }
ToNotebookPageTitle >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 8;
			   topRight: 8;
			   bottomLeft: 0;
			   bottomRight: 0;
			   yourself)
]

{ #category : 'skin' }
ToNotebookPageTitle >> hoveredBackground [

	^ Color white
]

{ #category : 'initialization' }
ToNotebookPageTitle >> initialize [

	super initialize.
	labelElement := ToLabel new.
	self addChild: labelElement.

]

{ #category : 'skin' }
ToNotebookPageTitle >> installRawStyle [

	| closeButton |
	super installRawStyle.

	self fitContent.
	labelElement padding: self labelPadding.
	labelElement constraintsDo: [ :c | c linear vertical alignCenter ].
	self padding: self defaultPadding.
	self border: Color black.
	self geometry: self defaultGeometry.

	closeButton := self childWithId: #closeButton ifNone: [^ self ].
	closeButton withoutSkin
]

{ #category : 'accessing' }
ToNotebookPageTitle >> labelElement [

	^ labelElement
]

{ #category : 'skin' }
ToNotebookPageTitle >> labelPadding [

	^ BlInsets top: 4 left: 10 bottom: 4 right: 10
]

{ #category : 'accessing' }
ToNotebookPageTitle >> page [

	^ page
]

{ #category : 'accessing' }
ToNotebookPageTitle >> page: aPage [

	page := aPage
]

{ #category : 'skin' }
ToNotebookPageTitle >> rawSkin [ 

	^ ToNoteBookPageTitleSkin new
]

{ #category : 'accessing' }
ToNotebookPageTitle >> title: aString [ 
	
	labelElement text: aString asRopedText
]
