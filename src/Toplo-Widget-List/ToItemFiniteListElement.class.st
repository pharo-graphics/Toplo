"
I'm a list whose node contents is a BlElement
"
Class {
	#name : #ToItemFiniteListElement,
	#superclass : #ToItemListElement,
	#traits : 'TToFiniteListElement',
	#classTraits : 'TToFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #initialization }
ToItemFiniteListElement >> defaultUseInfiniteLayout [ 

	^ false
]
