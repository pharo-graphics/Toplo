Class {
	#name : #ToTabPaneGroupElement,
	#superclass : #ToTabGroupElement,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #initialization }
ToTabPaneGroupElement >> barElementClass [

	^ ToTabPaneBarElement 
]

{ #category : #adding }
ToTabPaneGroupElement >> newTabItem [

	^ ToTabButton new
]
