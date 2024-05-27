Class {
	#name : #ToListNode,
	#superclass : #BlElement,
	#traits : 'TToEnableable + TToListNode',
	#classTraits : 'TToEnableable classTrait + TToListNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - list node' }
ToListNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToListNode >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self setInitialConfiguration 
]
