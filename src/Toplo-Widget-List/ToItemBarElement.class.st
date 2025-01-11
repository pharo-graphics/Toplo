"
I'm a Bar whose node child is a unique BlElement.
The unique child is call an item
"
Class {
	#name : #ToItemBarElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemBarElement >> defaultNodeManagerClass [

	^ ToItemNodeManager
]

{ #category : #initialization }
ToItemBarElement >> initialize [

	super initialize.
	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #'t - orientable - accessing' }
ToItemBarElement >> layoutStrategy [

	^ self layout

	
]

{ #category : #skin }
ToItemBarElement >> newRawSkin [ 

	^ ToItemBarElementSkin new
]
