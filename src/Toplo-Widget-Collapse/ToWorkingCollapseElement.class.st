Class {
	#name : #ToWorkingCollapseElement,
	#superclass : #ToElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#instVars : [
		'body',
		'headerBuilder',
		'clickHandler',
		'clickEventClass',
		'isCollapsed',
		'header',
		'headerContainer',
		'iconContainer'
	],
	#category : #'Toplo-Widget-Collapse'
}

{ #category : #examples }
ToWorkingCollapseElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self new.
	inst builder: [ :header | header addChild: (ToLabel text: 'coucou') ].
	inst openInSpace.
	^ inst
]

{ #category : #accessing }
ToWorkingCollapseElement >> builder: aValuable [
	"With an header as argument"
	
	aValuable value: header
]

{ #category : #'t - clickable' }
ToWorkingCollapseElement >> clickHandler [

	^ clickHandler 
]

{ #category : #'t - clickable' }
ToWorkingCollapseElement >> clickHandler: anHandler [

	clickHandler := anHandler
]

{ #category : #'expanding-collapsing' }
ToWorkingCollapseElement >> collapse [

	body removeFromParent
]

{ #category : #'expanding-collapsing' }
ToWorkingCollapseElement >> expand [

	self addChild: body
]

{ #category : #accessing }
ToWorkingCollapseElement >> icon: aToImage [

	iconContainer removeChildren.
	iconContainer addChild: aToImage	
]

{ #category : #initialization }
ToWorkingCollapseElement >> initialize [

	super initialize.
	isCollapsed := true.
	self height: 30.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.
	self background: Color random.
	self initializeHeader.
	self initializeClick.
	self initializeBody.

]

{ #category : #initialization }
ToWorkingCollapseElement >> initializeBody [

	body := ToElement new
		        constraintsDo: [ :c |
			        c vertical fitContent.
			        c horizontal matchParent ];
		        border: (BlBorder paint: Color veryLightGray width: 1);
		        yourself.
	body addChild: (BlElement new
			 border: Color black;
			 background: Color black;
			 size: 50 @ 50)
]

{ #category : #initialization }
ToWorkingCollapseElement >> initializeClick [

	self whenClickedDo: [ :e |
		e consume.
		isCollapsed := isCollapsed not.
		isCollapsed
			ifFalse: [ self expand ]
			ifTrue: [ self collapse ] ]
]

{ #category : #initialization }
ToWorkingCollapseElement >> initializeHeader [

	headerContainer := ToElement new.
	headerContainer layout: BlLinearLayout horizontal.
	headerContainer hMatchParent.
	headerContainer vFitContent.
	self addChild: headerContainer.

	header := ToElement new.
	header hMatchParent.
	header vFitContent.

	iconContainer := ToElement new.
	iconContainer fitContent.
	headerContainer addChild: iconContainer.

	headerContainer addChild: header
]

{ #category : #initialization }
ToWorkingCollapseElement >> isCollapsed [ 
	
	^ isCollapsed 
]

{ #category : #skin }
ToWorkingCollapseElement >> newRawSkin [

	^ ToWorkingCollapseElementSkin new
]

{ #category : #'t - clickable' }
ToWorkingCollapseElement >> rawClickEventClass [

	^ clickEventClass
]

{ #category : #'t - clickable' }
ToWorkingCollapseElement >> rawClickEventClass: aClass [

	clickEventClass := aClass
]
