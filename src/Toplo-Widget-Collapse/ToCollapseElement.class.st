Class {
	#name : #ToCollapseElement,
	#superclass : #ToElement,
	#traits : 'TToButtonHolder + (TToTripletElement - {#properties:}) + TToLabeledIcon',
	#classTraits : 'TToButtonHolder classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait',
	#instVars : [
		'collapsed',
		'body'
	],
	#category : #'Toplo-Widget-Collapse'
}

{ #category : #examples }
ToCollapseElement class >> exampleWithLabel [

	<sampleInstance>
	| inst |
	inst := ToCollapseElement new.
	inst labelText: 'coucou'.
	inst openInSpace.
	^ inst
]

{ #category : #initialization }
ToCollapseElement >> buttonClass [

	^ ToButton
]

{ #category : #initialization }
ToCollapseElement >> collapse [

	body removeFromParent.
	
]

{ #category : #initialization }
ToCollapseElement >> expand [

	self addChild: body.
	
]

{ #category : #initialization }
ToCollapseElement >> initialize [

	super initialize.
	self initializeButtonHolder.
	collapsed := true.
	self height: 30.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.
	self background: Color random.

	self initializeBody.
	self initializeClick
]

{ #category : #initialization }
ToCollapseElement >> initializeBody [

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
ToCollapseElement >> initializeClick [

	self whenClickedDo: [ :e |
		e consume.
		collapsed := collapsed not.
		collapsed
			ifFalse: [ self expand ]
			ifTrue: [ self collapse ] ]
]

{ #category : #'t - triplet element - private - accessing' }
ToCollapseElement >> properties [

	^ self button properties
]
