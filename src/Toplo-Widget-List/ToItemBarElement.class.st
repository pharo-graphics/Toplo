"
I'm a list whose node contents is a BlElement
"
Class {
	#name : #ToItemBarElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement + TToItemBarElement',
	#classTraits : 'TToBarElement classTrait + TToItemBarElement classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
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
