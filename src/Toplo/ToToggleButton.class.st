Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToCheckableWidget',
	#classTraits : 'TToCheckableWidget classTrait',
	#instVars : [
		'fill'
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

{ #category : #private }
ToToggleButton >> privateFill [

	| e |
	e := BlElement new id: #fill.
	self isHorizontal
		ifTrue: [ 
			e constraintsDo: [ :c | 
				c vertical exact: 4.
				c horizontal matchParent ] ]
		ifFalse: [ 
			e constraintsDo: [ :c | 
				c horizontal exact: 4.
				c vertical matchParent ] ].
	^ e
]

{ #category : #private }
ToToggleButton >> privateUpdateChildren [

	self removeChildren.
	fill := self privateFill.
	self addChildren: ((self isLabelFirst
			  ifTrue: [ 
				  { 
					  label.
					  fill.
					  icon } ]
			  ifFalse: [ 
				  { 
					  icon.
					  fill.
					  label } ]) select: #notNil)
]
