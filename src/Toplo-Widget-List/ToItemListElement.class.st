Class {
	#name : #ToItemListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemListElement >> defaultNodeManagerClass [

	^ ToItemNodeManager
]

{ #category : #initialization }
ToItemListElement >> initialize [

	super initialize.
	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #'t - orientable - accessing' }
ToItemListElement >> layoutStrategy [

	^ self layout

	
]

{ #category : #skin }
ToItemListElement >> newRawSkin [ 

	^ ToItemListElementSkin new
]
