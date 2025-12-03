Class {
	#name : #ToTabPaneGroupElement,
	#superclass : #ToTabGroupElement,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #initialization }
ToTabPaneGroupElement >> barElementClass [

	^ ToTabPaneBarElement 
]

{ #category : #initialization }
ToTabPaneGroupElement >> defaultTabItemFactory [

	^ [ ToTabButton new ]
]
