"
I'm a list whose node contents is a BlElement
"
Class {
	#name : #ToItemBarElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement + TToItemList',
	#classTraits : 'TToBarElement classTrait + TToItemList classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
ToItemBarElement >> defaultNodeManagerClass [

	^ ToItemBarNodeManager
]

{ #category : #initialization }
ToItemBarElement >> initialize [

	super initialize.
	self initializeAsItemListElement
]

{ #category : #skin }
ToItemBarElement >> newRawSkin [ 

	^ ToItemBarElementSkin new
]
