Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
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
