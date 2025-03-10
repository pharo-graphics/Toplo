Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
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
	self clickEventClass: ToCheckableChangedEvent.

]

{ #category : #skin }
ToToggleButton >> newRawSkin [ 

	^ ToToggleButtonSkin new
]
