Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToCheckableWidget',
	#classTraits : 'TToCheckableWidget classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultDresser [

	^ ToToggleButtonDresser new
]

{ #category : #initialization }
ToToggleButton >> initialize [ 

	super initialize.
	self beJustified
]
