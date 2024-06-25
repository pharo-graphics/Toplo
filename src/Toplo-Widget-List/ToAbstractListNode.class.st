Class {
	#name : #ToAbstractListNode,
	#superclass : #ToElement,
	#traits : 'TToListNode',
	#classTraits : 'TToListNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToAbstractListNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToAbstractListNode >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
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
