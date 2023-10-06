Class {
	#name : #ToSelectItem,
	#superclass : #ToCheckMenuItem,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Select'
}

{ #category : #'as yet unclassified' }
ToSelectItem >> initialize [

	super initialize.
	self whenClickedDo: [ self switchToNextCheckState ].
	self addEventHandler: self defaultEventHandler
]
