Class {
	#name : #ToAccordionElement,
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
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #examples }
ToAccordionElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self new.
	inst builder: [ :header | header addChild: (ToLabel text: 'coucou') ].
	inst openInSpace.
	^ inst
]

{ #category : #accessing }
ToAccordionElement >> builder: aValuable [
	"With an header as argument"
	
	aValuable value: header
]

{ #category : #'t - clickable' }
ToAccordionElement >> clickHandler [

	^ clickHandler 
]

{ #category : #'t - clickable' }
ToAccordionElement >> clickHandler: anHandler [

	clickHandler := anHandler
]

{ #category : #'expanding-collapsing' }
ToAccordionElement >> collapse [

	body removeFromParent
]

{ #category : #'expanding-collapsing' }
ToAccordionElement >> expand [

	self addChild: body
]

{ #category : #accessing }
ToAccordionElement >> icon: aToImage [

	iconContainer removeChildren.
	iconContainer addChild: aToImage	
]

{ #category : #initialization }
ToAccordionElement >> initialize [

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
ToAccordionElement >> initializeBody [

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
ToAccordionElement >> initializeClick [

	self whenClickedDo: [ :e |
		e consume.
		isCollapsed := isCollapsed not.
		isCollapsed
			ifFalse: [ self expand ]
			ifTrue: [ self collapse ] ]
]

{ #category : #initialization }
ToAccordionElement >> initializeHeader [

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
ToAccordionElement >> isCollapsed [ 
	
	^ isCollapsed 
]

{ #category : #skin }
ToAccordionElement >> newRawSkin [

	^ ToAccordionElementSkin new
]

{ #category : #'t - clickable' }
ToAccordionElement >> rawClickEventClass [

	^ clickEventClass
]

{ #category : #'t - clickable' }
ToAccordionElement >> rawClickEventClass: aClass [

	clickEventClass := aClass
]
