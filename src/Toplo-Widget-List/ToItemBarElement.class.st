"
I'm a list whose node contents is a BlElement
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
