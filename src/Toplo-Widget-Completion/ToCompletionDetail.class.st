Class {
	#name : #ToCompletionDetail,
	#superclass : #ToElement,
	#instVars : [
		'method',
		'typeElement',
		'nameElement',
		'sourceElement'
	],
	#category : #'Toplo-Widget-Completion-Core'
}

{ #category : #initialization }
ToCompletionDetail >> initialize [ 

	super initialize.
	self constraintsDo: [ :c |
		c horizontal exact: 250.
		c vertical exact: 300. ].
	self layout: BlLinearLayout vertical.
	self initializeTypeElement.
	self initializeNameElement.
	self initializeSourceElement.
]

{ #category : #initialization }
ToCompletionDetail >> initializeNameElement [ 

	nameElement := ToLabel new.
	nameElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 20. ].
	
	nameElement background: Color lightGreen.
	self addChild: nameElement 
]

{ #category : #initialization }
ToCompletionDetail >> initializeSourceElement [ 

	sourceElement := ToLabel new.
	sourceElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent. ].
	
	self addChild: sourceElement.
]

{ #category : #initialization }
ToCompletionDetail >> initializeTypeElement [ 

	typeElement := ToLabel new.
	typeElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 20. ].
	
	self addChild: typeElement 
]

{ #category : #accessing }
ToCompletionDetail >> method [ 

	^ method
]

{ #category : #'instance creation' }
ToCompletionDetail >> newRawSkin [ 

	^ ToCompletionDetailSkin new
]

{ #category : #updating }
ToCompletionDetail >> updateWith: aCompiledMethod [ 

	method := aCompiledMethod.
	
	typeElement text: aCompiledMethod class name asRopedText.
	nameElement text: method selector asRopedText.
	sourceElement text: method sourceCode asRopedText.
	
]
