Class {
	#name : #ToNode,
	#superclass : #BlElement,
	#traits : 'TToEnableable',
	#classTraits : 'TToEnableable classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToNode >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]
