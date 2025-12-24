Class {
	#name : #ToTabPaneGroupElement,
	#superclass : #ToTabGroupElement,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #initialization }
ToTabPaneGroupElement >> defaultTabItemFactory [

	^ [ ToTabButton new ]
]

{ #category : #initialization }
ToTabPaneGroupElement >> listElementClass [

	^ ToTabPaneListElement 
]
