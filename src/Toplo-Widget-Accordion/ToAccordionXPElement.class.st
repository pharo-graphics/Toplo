"
This version works but failed to honor the clicked skin event because  (which is used as the underlying implementation for the header) the skin clicked event is not passed by design to the parent. 


"
Class {
	#name : #ToAccordionXPElement,
	#superclass : #ToElement,
	#traits : '',
	#classTraits : '',
	#instVars : [
		'body',
		'isCollapsed'
	],
	#category : #'Toplo-Widget-Accordion-XP'
}

{ #category : #examples }
ToAccordionXPElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := ToAccordionXPElement new.
	inst labelText: 'coucou'.
	inst addEventHandlerOn: ToSkinEvent do: [ :e | e traceCr ]. 
	inst openInSpace.
	^ inst
]

{ #category : #initialization }
ToAccordionXPElement >> buttonClass [

	^ ToButton
]

{ #category : #initialization }
ToAccordionXPElement >> collapse [

	body removeFromParent.
	
]

{ #category : #initialization }
ToAccordionXPElement >> expand [

	self addChild: body.
	
]

{ #category : #initialization }
ToAccordionXPElement >> initialize [

	super initialize.
	self initializeButtonHolder.
	isCollapsed := true.
	self height: 30.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.
	self background: Color random.

	self initializeBody.
	self initializeClick
]

{ #category : #initialization }
ToAccordionXPElement >> initializeBody [

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
ToAccordionXPElement >> initializeClick [

	self whenClickedDo: [ :e |
		e consume.
		isCollapsed := isCollapsed not.
		isCollapsed
			ifFalse: [ self expand ]
			ifTrue: [ self collapse ] ]
]

{ #category : #initialization }
ToAccordionXPElement >> isCollapsed [

	^ isCollapsed 
]

{ #category : #skin }
ToAccordionXPElement >> newRawSkin [

	^ ToAccordionXPElementSkin new 
]

{ #category : #'t - triplet element - private - accessing' }
ToAccordionXPElement >> properties [

	^ self button properties
]
