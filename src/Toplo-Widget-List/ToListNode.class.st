Class {
	#name : #ToListNode,
	#superclass : #BlElement,
	#traits : 'TToEnableable + TToListNode + TToUnanimityRequestTarget',
	#classTraits : 'TToEnableable classTrait + TToListNode classTrait + TToUnanimityRequestTarget classTrait',
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
