Class {
	#name : #ToToggleButton,
	#superclass : #ToMultiStateButton,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultDresser [

	^ ToToggleButtonDresser new
]

{ #category : #initialization }
ToToggleButton >> initialize [ 

	super initialize.
	self beJustified.

]
