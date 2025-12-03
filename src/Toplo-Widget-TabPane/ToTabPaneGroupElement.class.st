Class {
	#name : #ToTabPaneGroupElement,
	#superclass : #ToTabGroupElement,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #initialization }
ToTabPaneGroupElement >> barElementClass [

	^ ToTabPaneFiniteListElement 
]

{ #category : #initialization }
ToTabPaneGroupElement >> defaultTabItemFactory [

	^ [ ToTabButton new ]
]
