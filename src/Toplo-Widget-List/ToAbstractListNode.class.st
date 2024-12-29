"
We have two types of list with or without infinite. This different is reflected in their children. 
The element children of an infinite list are `ToListNode`, the other are `ToBarNode`

"
Class {
	#name : #ToAbstractListNode,
	#superclass : #ToElement,
	#traits : 'TToListNode',
	#classTraits : 'TToListNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToAbstractListNode >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout new
]

{ #category : #initialization }
ToAbstractListNode >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: false.
	self layout: self defaultLayout
]

{ #category : #testing }
ToAbstractListNode >> isFirst [

	^ self holder position = 1
]

{ #category : #testing }
ToAbstractListNode >> isHorizontal [

	^ self holder listElement isHorizontal
]

{ #category : #testing }
ToAbstractListNode >> isLast [

	^ self holder position = self holder dataSource itemCount 
]

{ #category : #testing }
ToAbstractListNode >> isSelected [

	^ self holder isSelected
]
