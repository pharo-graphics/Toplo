Class {
	#name : 'ToSelectItem',
	#superclass : 'ToCheckMenuItem',
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'as yet unclassified' }
ToSelectItem >> initialize [

	super initialize.
	self whenClickedDo: [ self switchToNextCheckStateOnClick ].
	self addEventHandler: self defaultEventHandler
]
