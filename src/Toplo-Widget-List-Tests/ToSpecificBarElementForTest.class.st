Class {
	#name : #ToSpecificBarElementForTest,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #initialization }
ToSpecificBarElementForTest >> applyInnerConfiguration [ 

	self configureLayout.
	super applyInnerConfiguration 
]

{ #category : #initialization }
ToSpecificBarElementForTest >> defaultNodeManagerClass [

	^ ToSpecificBarNodeManagerForTest
]

{ #category : #initialization }
ToSpecificBarElementForTest >> initialize [ 

	super initialize.
	self configureLayout
]
