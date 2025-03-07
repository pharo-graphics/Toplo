Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToLinkableWithModel + TToItem',
	#classTraits : 'TToLinkableWithModel classTrait + TToItem classTrait',
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #configuration }
ToToggleButton >> checkable: aBoolean [

	self shouldNotImplement 
]

{ #category : #initialization }
ToToggleButton >> initialize [ 

	super initialize.
	self initializeAsCheckable.
	self clickEventClass: ToCheckableCheckEvent.

]

{ #category : #skin }
ToToggleButton >> newRawSkin [ 

	^ ToToggleButtonSkin new
]
