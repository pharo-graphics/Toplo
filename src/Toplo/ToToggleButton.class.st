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

{ #category : #factory }
ToToggleButton class >> horizontal [

	^ ToHorizontalToggleButton new
]

{ #category : #factory }
ToToggleButton class >> vertical [

	^ ToVerticalToggleButton new
]

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
	self justifyLayout 
]
