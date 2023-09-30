Class {
	#name : #ToSelectItem,
	#superclass : #ToCheckMenuItem,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Select'
}

{ #category : #initialization }
ToSelectItem >> defaultEventHandler [

	^ ToSelectItemEventHandler new
]

{ #category : #initialization }
ToSelectItem >> initialize [

	super initialize.
	self initializeCheckable.
	self whenClickedDo: [ self switchCheckState ].
	self addEventHandler: self defaultEventHandler
]
