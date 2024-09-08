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
	self layout: self defaultLayout
]

{ #category : #testing }
ToAbstractListNode >> isHorizontal [

	^ self holder listElement isHorizontal
]

{ #category : #testing }
ToAbstractListNode >> isSelected [

	^ self holder isSelected
]
