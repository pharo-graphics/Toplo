Class {
	#name : #ToBasicAccordionElement,
	#superclass : #ToElement,
	#traits : 'TToButtonHolder',
	#classTraits : 'TToButtonHolder classTrait',
	#instVars : [
		'body',
		'headerBuilder',
		'isCollapsed'
	],
	#category : #'Toplo-Widget-Accordion-XP'
}

{ #category : #examples }
ToBasicAccordionElement class >> example [

	<script>
	| inst |
	inst := self new.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToBasicAccordionElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self new.
	inst builder: [ :header | header addChild: (ToLabel text: 'coucou') ].
	inst openInSpace.
	^ inst
]

{ #category : #initialization }
ToBasicAccordionElement >> builder: aValuable [

	aValuable value: self button
]

{ #category : #initialization }
ToBasicAccordionElement >> buttonClass [

	^ ToGeneralButton
]

{ #category : #initialization }
ToBasicAccordionElement >> collapse [

	body removeFromParent.
	
]

{ #category : #initialization }
ToBasicAccordionElement >> expand [

	self addChild: body.
	
]

{ #category : #initialization }
ToBasicAccordionElement >> initialize [

	super initialize.
	self initializeButtonHolder.
	isCollapsed := true.
	self height: 30.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.
	self background: Color random.
	self initializeClick.
	self initializeBody
]

{ #category : #initialization }
ToBasicAccordionElement >> initializeBody [

	body := ToElement new
		           constraintsDo: [ :c |
			           c vertical fitContent.
			           c horizontal matchParent ];
		           border: (BlBorder paint: Color veryLightGray width: 1);
		           yourself.
	body addChild: (BlElement new
			 border: Color black;
			 background: Color black;
			 size: 50 @ 50).
	
]

{ #category : #initialization }
ToBasicAccordionElement >> initializeClick [

	self whenClickedDo: [ :e |
		e consume.
		isCollapsed := isCollapsed not.
		isCollapsed
			ifFalse: [ self expand ]
			ifTrue: [ self collapse ] ]
]
