Class {
	#name : #ToTabPaneGroupElement,
	#superclass : #ToTabGroupElement,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #initialization }
ToTabPaneGroupElement >> barElementClass [

	^ ToTabPaneBarElement 
]

{ #category : #initialization }
ToTabPaneGroupElement >> defaultTabItemFactory [

	^ [ ToTabButton new ]
]
