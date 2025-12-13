Class {
	#name : #ToTreeTableListElement,
	#superclass : #ToTreeElement,
	#traits : 'TToTableListElement',
	#classTraits : 'TToTableListElement classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTreeTableListElement >> defaultNodeManagerClass [

	^ ToTreeTableNodeManager
]

{ #category : #initialization }
ToTreeTableListElement >> initialize [

	super initialize.
	self addStamp: #geometry withValue: BlRectangleGeometry new.
]
