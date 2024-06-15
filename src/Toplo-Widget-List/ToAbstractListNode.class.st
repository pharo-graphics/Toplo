Class {
	#name : #ToAbstractListNode,
	#superclass : #BlElement,
	#traits : 'TToEnableable + TToListNode + TToAuthorisationRequestTarget + TBlLayoutResizable',
	#classTraits : 'TToEnableable classTrait + TToListNode classTrait + TToAuthorisationRequestTarget classTrait + TBlLayoutResizable classTrait',
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
