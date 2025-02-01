"
I'm a list whose node contents is a BlElement
"
Class {
	#name : #ToItemBarElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement + TToItemListElement',
	#classTraits : 'TToBarElement classTrait + TToItemListElement classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemBarElement >> initialize [

	super initialize.
	self initializeAsItemBarElement 
]

{ #category : #skin }
ToItemBarElement >> newRawSkin [ 

	^ ToItemBarElementSkin new
]
