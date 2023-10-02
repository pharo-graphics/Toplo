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

{ #category : #'as yet unclassified' }
ToSelectItem >> initialize [

	super initialize.
	self whenClickedDo: [ self switchToNextCheckState ].
	self addEventHandler: self defaultEventHandler
]
