Class {
	#name : #ToAbstractListNode,
	#superclass : #BlElement,
	#traits : 'TToEnableable + TToListNode + TToUnanimityRequestTarget',
	#classTraits : 'TToEnableable classTrait + TToListNode classTrait + TToUnanimityRequestTarget classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToAbstractListNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToAbstractListNode >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self addEventHandler: self newEventHandler 
]

{ #category : #testing }
ToAbstractListNode >> isSelected [

	^ self holder isSelected
]

{ #category : #'instance creation' }
ToAbstractListNode >> newEventHandler [

	^ ToListNodeEventHandler new
]
