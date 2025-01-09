Class {
	#name : #ToBasicCollapseElement,
	#superclass : #ToElement,
	#traits : 'TToButtonHolder',
	#classTraits : 'TToButtonHolder classTrait',
	#instVars : [
		'collapsed',
		'body',
		'headerBuilder'
	],
	#category : #'Toplo-Widget-Collapse'
}

{ #category : #examples }
ToBasicCollapseElement class >> example [

	<sampleInstance>
	| inst |
	inst := self new.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToBasicCollapseElement class >> exampleWithLabel [

	<sampleInstance>
	| inst |
	inst := self new.
	inst builder: [ :header | header addChild: (ToLabel text: 'coucou') ].
	inst openInSpace.
	^ inst
]

{ #category : #initialization }
ToBasicCollapseElement >> builder: aValuable [

	aValuable value: self button
]

{ #category : #initialization }
ToBasicCollapseElement >> buttonClass [

	^ ToGeneralButton
]

{ #category : #initialization }
ToBasicCollapseElement >> collapse [

	body removeFromParent.
	
]

{ #category : #initialization }
ToBasicCollapseElement >> expand [

	self addChild: body.
	
]

{ #category : #initialization }
ToBasicCollapseElement >> initialize [

	super initialize.
	self initializeButtonHolder.
	collapsed := true.
	self height: 30.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.
	self background: Color random.
	self initializeClick.
	self initializeBody
]

{ #category : #initialization }
ToBasicCollapseElement >> initializeBody [

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
ToBasicCollapseElement >> initializeClick [

	self whenClickedDo: [ :e |
		e consume.
		collapsed := collapsed not.
		collapsed
			ifFalse: [ self expand ]
			ifTrue: [ self collapse ] ]
]
