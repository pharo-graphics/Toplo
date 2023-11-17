Class {
	#name : 'ToNotebookPageButton',
	#superclass : 'ToGeneralButton',
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'page',
		'labelElement'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'skin' }
ToNotebookPageButton >> defaultBorder [

	self page isSelected ifTrue: [
		^ Color fromHexString: #ffd666 ].
	^ Color veryLightGray alpha: 0.5
]

{ #category : 'skin' }
ToNotebookPageButton >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 8;
			   topRight: 8;
			   bottomLeft: 0;
			   bottomRight: 0;
			   yourself)
]

{ #category : 'skin' }
ToNotebookPageButton >> hoveredBackground [

	^ Color white
]

{ #category : 'initialization' }
ToNotebookPageButton >> initialize [

	super initialize.
	labelElement := ToLabel new.
	self addChild: labelElement.

]

{ #category : 'skin' }
ToNotebookPageButton >> installRawStyle [

	super installRawStyle.

	self fitContent.
	labelElement padding: self labelPadding.
	labelElement constraintsDo: [ :c | c linear vertical alignCenter ].
	self padding: self defaultPadding.
	self border: Color black.
	self geometry: self defaultGeometry.
	
]

{ #category : 'testing' }
ToNotebookPageButton >> isSelected [

	" since checked can be nil, test is with = "
	^ self isChecked
]

{ #category : 'accessing' }
ToNotebookPageButton >> labelElement [

	^ labelElement
]

{ #category : 'skin' }
ToNotebookPageButton >> labelPadding [

	^ BlInsets top: 4 left: 10 bottom: 4 right: 10
]

{ #category : 'accessing' }
ToNotebookPageButton >> labelText: aText [ 
	
	labelElement text: aText asRopedText
]

{ #category : 'skin' }
ToNotebookPageButton >> newRawSkin [ 

	^ ToNotebookPageButtonSkin new
]

{ #category : 'accessing' }
ToNotebookPageButton >> page [

	^ page
]

{ #category : 'accessing' }
ToNotebookPageButton >> page: aPage [

	page := aPage
]

{ #category : 'skin' }
ToNotebookPageButton >> selectedBackground [

	^ Color fromHexString: #ffd666
]
