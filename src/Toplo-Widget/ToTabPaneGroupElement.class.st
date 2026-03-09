Class {
	#name : #ToTabPaneGroupElement,
	#superclass : #ToTabGroupElement,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #initialization }
ToTabPaneGroupElement >> defaultTabItemFactory [

	^ [ ToTabButton new ]
]

{ #category : #initialization }
ToTabPaneGroupElement >> listElementClass [

	^ ToTabPaneListElement 
]
