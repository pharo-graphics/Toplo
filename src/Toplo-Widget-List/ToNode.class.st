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
	self padding: (BlInsets horizontal: 4).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #dependencies }
ToNode >> release [ 

	self removeChildren.
	super release.

]
