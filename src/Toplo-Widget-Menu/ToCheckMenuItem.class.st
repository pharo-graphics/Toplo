Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToCheckMenuItem >> defaultEventHandler [ 

	^ ToCheckableEventHandler new
]

{ #category : #initialization }
ToCheckMenuItem >> initialize [

	super initialize.
	self initializeCheckable 
]
