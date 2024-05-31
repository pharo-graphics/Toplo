Class {
	#name : #ToListNode,
	#superclass : #BlElement,
	#traits : 'TToEnableable + TToListNode + TToPrenotificationTarget',
	#classTraits : 'TToEnableable classTrait + TToListNode classTrait + TToPrenotificationTarget classTrait',
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
