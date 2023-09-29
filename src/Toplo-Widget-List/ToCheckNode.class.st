Class {
	#name : #ToCheckNode,
	#superclass : #ToLabeledNode,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-List-node'
}

{ #category : #'t - initialization dresser' }
ToCheckNode >> defaultDresser [

	^ToCheckNodeDresser new
]

{ #category : #initialization }
ToCheckNode >> initialize [

	super initialize.
	self initializeCheckable 
]
