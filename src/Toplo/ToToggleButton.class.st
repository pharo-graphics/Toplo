Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToCheckableWidget',
	#classTraits : 'TToCheckableWidget classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultDresser [

	^ ToToggleButtonDresser new
]

{ #category : #accessing }
ToToggleButton >> group [

	^ group
]

{ #category : #accessing }
ToToggleButton >> group: aToggleGroup [

	group := aToggleGroup
]

{ #category : #initialization }
ToToggleButton >> initialize [ 

	super initialize.
	self beJustified
]
