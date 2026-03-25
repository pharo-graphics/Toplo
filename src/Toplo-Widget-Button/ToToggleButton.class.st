Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
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
	self clickEventClass: ToCheckableChangedEvent
]

{ #category : #'t - element with action' }
ToToggleButton >> newClickAction: aValuable [

	^ self newCheckAction: aValuable
]

{ #category : #skin }
ToToggleButton >> newRawSkin [ 

	^ ToToggleButtonSkin new
]
