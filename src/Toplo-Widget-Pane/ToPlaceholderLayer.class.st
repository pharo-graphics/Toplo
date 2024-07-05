Class {
	#name : #ToPlaceholderLayer,
	#superclass : #ToOverlayElement,
	#traits : 'TToElement + TToEnableable',
	#classTraits : 'TToElement classTrait + TToEnableable classTrait',
	#category : #'Toplo-Widget-Pane'
}

{ #category : #initialization }
ToPlaceholderLayer >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #initialization }
ToPlaceholderLayer >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self initializeForToplo 

	
]
